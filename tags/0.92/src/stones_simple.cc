/*
 * Copyright (C) 2002,2003,2004 Daniel Heck
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program; if not, write to the Free Software Foundation, Inc.,
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307, USA.
 *
 * $Id: stones_simple.cc,v 1.71 2004/03/18 18:09:23 dheck Exp $
 */
#include "laser.hh"
#include "server.hh"
#include "player.hh"
#include "client.hh"

#include "stones_internal.hh"

#include <cassert>

using namespace std;
using namespace world;
using namespace stones;


/* -------------------- SimpleStoneTraits -------------------- */

namespace
{
    /*! This class stores some atrributes for SimpleStones.  Only one
      instance is created for each type of SimpleStone. */

    struct SimpleStoneTraits {
        string sound;           // collision sound
        bool   hollow;          // whether stone is hollow
        bool   glass;           // whether it's a glass stone

        // static list of all allocated SimpleStoneTraits (never freed yet)
        static vector<SimpleStoneTraits*> simple_stone_traits;

        SimpleStoneTraits(const string& sound_, bool hollow_, bool glass_)
        : sound(sound_) , hollow(hollow_) , glass(glass_)
        {}

    public:
        SimpleStoneTraits() {}

//         static void clear() {
//             vector<SimpleStoneTraits*>::iterator i = simple_stone_traits.begin();
//             vector<SimpleStoneTraits*>::iterator e = simple_stone_traits.end();
//             for (; i != e; ++e)
//                 delete simple_stone_traits[i];
//             simple_stone_traits.clear();
//         }

        static const SimpleStoneTraits* Register(const string& sound_, bool hollow_, bool glass_) {
            simple_stone_traits.push_back(new SimpleStoneTraits(sound_, hollow_, glass_));
            return simple_stone_traits.back();
        }
    };

    vector<SimpleStoneTraits*> SimpleStoneTraits::simple_stone_traits;
}


/* -------------------- SimpleStone -------------------- */

namespace
{
    class SimpleStone : public Stone {
    public:
        SimpleStone(const string &knd, const string & snd, 
                    bool hollow, bool is_glass)
        : Stone(knd.c_str()), 
          traits(SimpleStoneTraits::Register(snd, hollow, is_glass)),
          sunglasses(false)
        {}
    private:
        SimpleStone(const SimpleStone& other)
        : Stone(other.get_kind()), traits(other.traits)
        {}

        Stone *clone() { return new SimpleStone(*this); }
        void dispose() { delete this; }

        const char *collision_sound() {
            return traits->sound.c_str();
        }
        StoneResponse collision_response(const StoneContact &sc) {
            if (traits->hollow)
                return STONE_PASS;
            if (traits->glass && sc.actor->is_invisible())
                return STONE_PASS;
            return STONE_REBOUND;
        }

        bool is_sticky (const Actor *actor) const {
            if (traits->glass)
                return !actor->is_invisible();
            return Stone::is_sticky(actor);
        }

        bool is_floating() const {
            return traits->hollow;
        }
        bool is_transparent (Direction) const {
            return traits->hollow || traits->glass;
        }

        void on_message (const Message &m)
        {
            if (traits->hollow && m.message == "glasses") {
                if (to_int(m.value)) {
                    if (!sunglasses) {
                        sunglasses = true;
                        set_model( "invisible");
                    }
                }
                else {
                    if (sunglasses) {
                        sunglasses = false;
                        set_model (this->get_kind());
                    }
                }
            }
        }

        const SimpleStoneTraits *traits; // owned by simple_stone_traits
        bool sunglasses; // seen through glasses
    };
}


/* -------------------- SimpleStoneMovable -------------------- */

namespace
{
    class SimpleStoneMovable : public Stone {
    public:
        SimpleStoneMovable(const string &knd, const string & snd, bool is_glass)
        : Stone (knd.c_str()), 
          traits(SimpleStoneTraits::Register(snd, false, is_glass))
        {}

    private:
        SimpleStoneMovable(const SimpleStoneMovable& other)
        : Stone (other.get_kind()), 
          traits (other.traits)
        {}

        Stone *clone() { return new SimpleStoneMovable(*this); }
        void dispose() { delete this; }

        const char *collision_sound() {
            return traits->sound.c_str();
        }
        bool is_transparent (Direction) const {
            return traits->glass;
        }

        bool is_movable() const { return true; }

        const SimpleStoneTraits *traits; // owned by simple_stone_traits
    };
}


/* -------------------- DummyStone -------------------- */

namespace
{
    /*! Used for debugging; Prints its own oxyd code when hit. */
    class DummyStone : public Stone {
        CLONEOBJ(DummyStone);
    public:
        DummyStone() : Stone("st-dummy") {}
    private:

        StoneResponse collision_response(const StoneContact &/*sc*/) {
            static int lastCode = -1;
            int        code     = int_attrib("code");
            if (code != lastCode) {
                fprintf(stderr, "Collision with stone 0x%02x\n", code);
                lastCode = code;
            }
            return STONE_REBOUND;
        }
    };
}


/* -------------------- EasyModeStone -------------------- */

/** \page st-easymode Easy-Mode Stone

In easy game mode this stone converts the floor at its
position to fl-normal.
In normal game mode the stone kills any item at its position.
Then in both modes it kills itself.

E.g. it can be used to hide water-barriers or to insert helper
items that make the level easier in easy game mode.

\subsection easye Example
\verbatim
set_stone("st-easymode", 10,10)
\endverbatim

\ref it-easymode
*/

namespace
{
    class EasyModeStone : public Stone {
        CLONEOBJ(EasyModeStone);
        DECL_TRAITS;

        void message(const std::string &msg, const Value&) {
            if (msg == "init") {
                if (server::GetDifficulty() == DIFFICULTY_EASY) {
                    SetFloor (get_pos(), MakeFloor ("fl-normal"));
                } else {
                    KillItem (get_pos());
                }
                KillStone (get_pos());
            }
        }
    public:
        EasyModeStone() 
        {}
    };
    DEF_TRAITS(EasyModeStone, "st-easymode", st_easymode);
}


/* -------------------- Grates -------------------- */

namespace
{
    class GrateBase : public Stone {
    public:
        GrateBase(const char *kind) : Stone(kind) {}
    private:
        bool is_floating() const { return true; }
        bool is_transparent (Direction) const { return true; }

        virtual StoneResponse collision_response(const StoneContact &sc) {
            if (server::GameCompatibility == GAMET_OXYD1) {
                return STONE_PASS;
            }
            // tested with per.oxyd
            return sc.actor->is_on_floor() ? STONE_PASS : STONE_REBOUND;
        }
    };

    class Grate1 : public GrateBase {
        CLONEOBJ(Grate1);
    public:
        Grate1() : GrateBase("st-grate1") {}
    };

    class Grate2 : public GrateBase {
        CLONEOBJ(Grate2);
    public:
        Grate2() : GrateBase("st-grate2") {}
    };

    /*! Horses and small marbles can move through this stone, but
      normal marbles can't. */
    class Grate3 : public GrateBase {
        CLONEOBJ(Grate3);
    public:
        Grate3() : GrateBase("st-grate3") {}

        StoneResponse collision_response(const StoneContact &sc) {
            ActorID id = get_id(sc.actor);
            if (id == ac_horse || id == ac_meditation || id == ac_killerball)
                return STONE_PASS;
            else
                return STONE_REBOUND;
        }
    };
}


/* -------------------- Chameleon Stone -------------------- */

namespace
{
    class ChameleonStone : public Stone {
        CLONEOBJ(ChameleonStone);
        DECL_TRAITS;

        void init_model() {
            string modelname = "fl-gray";
            if (Floor *fl = GetFloor(get_pos()))
                modelname = fl->get_kind();
            set_model(modelname);
        }

        bool is_floating() const 
        { return true; }

        StoneResponse collision_response(const StoneContact &)
        { return STONE_PASS; }

    public:
        ChameleonStone() 
        {}
    };
    DEF_TRAITS(ChameleonStone, "st-chameleon", st_chameleon);
}


/* -------------------- SwapStone -------------------- */

namespace
{
    class SwapStone : public Stone, public TimeHandler {
    public:
        SwapStone();
    private:
        // Object interface
        SwapStone *clone();
        void       dispose();

        // GridObject interface
        void init_model();
        void on_removal(GridPos p);

        // Stone interface
        void on_impulse (const Impulse &impulse);
        bool is_removable() const { return state == IDLE; }
        void actor_hit (const StoneContact &sc);

        // TimeHandler interface
        void alarm();

        // Variables :
        enum State { IDLE, COME, GO } state;
        YieldedGridStone *in_exchange_with;
        Direction         move_dir;
    };
}

SwapStone::SwapStone()
: Stone("st-swap"),
  state(IDLE),
  in_exchange_with(0),
  move_dir(NODIR)
{}

SwapStone *SwapStone::clone() {
    SwapStone *other        = new SwapStone(*this);
    other->in_exchange_with = 0;
    return other;
}

void SwapStone::dispose() {
    if (state == COME && in_exchange_with != 0) {
        in_exchange_with->dispose();
        delete in_exchange_with;
    }
    delete this;
}

void SwapStone::on_removal(GridPos p) {
    if (state == COME) {
        GameTimer.remove_alarm(this);
    }
}

/* Animation finished; put the "swapped" stone to its new position. */
void SwapStone::alarm()
{
    GridPos oldPos = move(get_pos(), reverse(move_dir));

    // Set the swapped stone (this also kills the old (inactive) swap stone)
    in_exchange_with->set_stone(oldPos);
    delete in_exchange_with;
    in_exchange_with = 0;

    state = IDLE;
    init_model();
//    sound_event ("moveslow");
}

void SwapStone::on_impulse(const Impulse& impulse) 
{
    if (state == IDLE) {
        GridPos oldp = get_pos();
        GridPos newp = move(oldp, impulse.dir);

        if (!IsLevelBorder(newp)) {
            Stone *other = GetStone(newp);
            if (other && other->is_removable()) {
                SwapStone *newStone = new SwapStone;
                newStone->state            = COME;
                newStone->in_exchange_with = new YieldedGridStone(other); // yields 'other'
                newStone->move_dir         = impulse.dir;

                GameTimer.set_alarm(newStone, 0.1, false);

                SetStone(newp, newStone);

                state    = GO;
                move_dir = impulse.dir;
                init_model();

                sound_event ("moveslow");
                server::IncMoveCounter(1);
            }
        }
    }
}

void SwapStone::actor_hit(const StoneContact &sc) {
    Direction dir = get_push_direction (sc);
    if (dir != NODIR) {
        send_impulse(get_pos(), dir);
    }
}

void SwapStone::init_model() {
    static const char *models_come[] = { "st-swap-w", "st-swap-s", "st-swap-e", "st-swap-n" };
    static const char *models_go[] =   { "st-swap-e", "st-swap-n", "st-swap-w", "st-swap-s" };

    const char *model = 0;
    switch (state) {
    case IDLE: model = "st-swap"; break;
    case COME: model = models_come[move_dir]; break;
    case GO:   model = models_go[move_dir]; break;
    }

    set_model(model);
}


/* -------------------- BlockStone -------------------- */

namespace
{
    class BlockStone : public Stone {
        CLONEOBJ(BlockStone);
    public:
        BlockStone() : Stone("st-block") {}
    private:
        V2 get_center() const {
            return get_pos().center();
        }

        void on_floor_change() {
            if (Floor *fl=GetFloor(get_pos())) {
                const string &k = fl->get_kind();
                if (k=="fl-water" || k=="fl-abyss" || k == "fl-swamp") {
                    client::Msg_Sparkle (get_center());
                    KillStone(get_pos());
                }
            }
        }
        bool is_movable () const { return true; }
    };

};


/* -------------------- Window -------------------- */

/** \page st-window Breakable Stone

Hit this window heavily with your marble to blast it into smithereens.

\image html st-window.png
*/

namespace
{
    class Window : public Stone {
        CLONEOBJ(Window);
        DECL_TRAITS;
        const char *collision_sound() {return "glass";}

        bool is_transparent (Direction) const { return true; }
        bool is_floating() const { return state != IDLE; }
        enum State { IDLE, BREAK } state;

        void actor_hit(const StoneContact &sc) {
            Actor *a = sc.actor;
            if (state == IDLE) {
	    	double impulse = -(a->get_vel() * sc.normal) * get_mass(a);
        	if (impulse > 35) {
        	    SendMessage(a, "shatter");
        	}

		if (impulse > 25) {
                    sound_event ("shatter");
                    state = BREAK;
                    set_anim("st-window-anim");
                }
            }
        }
        void animcb() {
            KillStone(get_pos());
        }
    public:
        Window() : state(IDLE) {}
    };
    DEF_TRAITS(Window, "st-window", st_window);
}

// -----------------------
//      BreakableStone
// -----------------------
// base class for Stone_break, Break_Bolder, Break_acwhite and Break_acblack
//
// breakable stones can be destroyed using
// hammer, laser, dynamite, bombs or bombstones

namespace 
{
    class BreakableStone : public Stone {
    public:
        BreakableStone(const char *kind) : Stone(kind), state(IDLE) {}
    protected:
        void break_me() {
            if (state == IDLE) {
                state = BREAK;
                sound_event ("stonedestroy");
                set_anim(get_break_anim());
            }
        }
    private:
        const char *collision_sound() { return "stone"; }

        void actor_hit(const StoneContact &sc) {
            if (may_be_broken_by(sc.actor))
                break_me();
        }
        void on_laserhit(Direction) {
            break_me();
        }
        void animcb() {
            KillStone(get_pos());
        }
        void message(const string &msg, const Value &) {
            if (msg =="ignite" || msg == "expl" || msg == "bombstone")
                break_me();
        }

        virtual string get_break_anim() const  {
            return string(get_kind())+"-anim";
        }
        virtual bool may_be_broken_by(Actor *a) const = 0;

        // variables:

        enum State { IDLE, BREAK };
        State state;
    };
}

//----------------------------------------
// Stone_break
//----------------------------------------

/** \page st-stone_break Breakable Stone

This stone can be destroyed by an actor having a
hammer and by laser, dynamite, bombs and bombstones.

\subsection stone_breake Example
\verbatim
set_stone("st-stone_break", 10,10)
\endverbatim

\image html st-stone_break.png
*/
namespace
{
    class Stone_break : public BreakableStone {
        CLONEOBJ(Stone_break);
    public:
        Stone_break(const char *kind) : BreakableStone(kind) { }
    private:
        bool may_be_broken_by(Actor *a) const {
            return player::wielded_item_is(a, "it-hammer");
        }
    };

    class LaserBreakable : public BreakableStone {
        CLONEOBJ (LaserBreakable);

        void actor_hit(const StoneContact &) {
        }
        bool may_be_broken_by(Actor *) const {
            return false;
        }
    public:

        LaserBreakable(): BreakableStone("st-laserbreak") {
        }
    };
}


//----------------------------------------
// Break_bolder
//----------------------------------------

/** \page st-break_bolder Breakable Stone

This stone can be destroyed by an actor having a hammer and by laser,
dynamite, bombs and bombstones, bolder

\subsection break_bolder Example
\verbatim
set_stone("st-break_bolder", 10,10)
\endverbatim

\image html st-break_bolder.png
*/
namespace
{
    class Break_bolder : public BreakableStone {
        CLONEOBJ(Break_bolder);
    public:
        Break_bolder() : BreakableStone("st-break_bolder") {}
    private:
        bool may_be_broken_by(Actor *a) const {
            return player::wielded_item_is(a, "it-hammer");
        }
        virtual void message(const string &msg, const Value &) {
            if (msg == "trigger")
                break_me();
        }
    };
}

//----------------------------------------
// Stone_movebreak
//----------------------------------------

/** \page st-rock3_movebreak Breakable Movable Stone

This stone can be destroyed by an actor having a
hammer and by laser, dynamite, bombs and bombstones.

\subsection stone_breake Example
\verbatim
set_stone("st-rock3_movebreak", 10,10)
\endverbatim

\image html st-rock3.png
*/
namespace
{
    class Stone_movebreak : public BreakableStone {
        CLONEOBJ(Stone_movebreak);
    public:
        Stone_movebreak() : BreakableStone("st-rock3_movebreak") {}
    private:

        void on_laserhit(Direction) {
        }

        string get_break_anim() const  {
            return "st-rock3_break-anim";
        }
        bool may_be_broken_by(Actor *a) const {
            return player::wielded_item_is(a, "it-hammer");
        }

        bool is_movable() const { return true; }

        void actor_hit(const StoneContact &sc) {
            if (may_be_broken_by(sc.actor))
                break_me();
//             else
//                 maybe_push_stone (sc);
        }
        void on_impulse(const Impulse& impulse) {
            move_stone(impulse.dir);
        }

    };
}

//----------------------------------------
// Break_acwhite
//----------------------------------------

/** \page st-break_acwhite Breakable Stone

This stone can be destroyed by actor (whiteball) having a
hammer and by laser, dynamite, bombs and bombstones.

\subsection break_acwhite Example
\verbatim
set_stone("st-break_acwhite", 10,10)
\endverbatim

\image html st-break_acwhite.png
*/
namespace
{
    class Break_acwhite : public BreakableStone {
        CLONEOBJ(Break_acwhite);
    public:
        Break_acwhite() : BreakableStone("st-break_acwhite") {}
    private:
        bool may_be_broken_by(Actor *a) const {
            return a->get_attrib("whiteball") &&
                player::wielded_item_is(a, "it-hammer");
        }
    };
}

//----------------------------------------
// Break_acblack
//----------------------------------------

/** \page st-break_acblack Breakable Stone

This stone can be destroyed by actor (blackball) having a
hammer.

\subsection break_acblack Example
\verbatim
set_stone("st-break_acblack", 10,10)
\endverbatim

\image html st-break_acblack.png
*/
namespace
{
    class Break_acblack : public BreakableStone {
        CLONEOBJ(Break_acblack);
    public:
        Break_acblack() : BreakableStone("st-break_acblack") {}
    private:
        bool may_be_broken_by(Actor *a) const {
            return a->get_attrib("blackball") &&
                player::wielded_item_is(a, "it-hammer");
        }
    };
}


/* -------------------- BrickMagic -------------------- */

/** \page st-brick_magic Magic Brick Stone

This stone does initially look like a "st-brick". If touched by the
actor, having a magic wand, it turns into a "st-glass" stone and
allows lasers to go through it.

\subsection brick_magicke Example
\verbatim
set_stone("st-brick_magic", 10,10)
\endverbatim

\image html st-brick.png
*/
namespace
{
    class BrickMagic : public Stone {
        CLONEOBJ(BrickMagic);
        const char *collision_sound() {return "stone";}
    public:
        BrickMagic() : Stone("st-brick_magic") {}
    private:
        void actor_hit(const StoneContact &sc) {
            if (player::wielded_item_is(sc.actor, "it-magicwand")) {
                sound_event ("stonepaint");
                ReplaceStone (get_pos(), MakeStone("st-glass"));
            }
        }
    };
}


/* -------------------- Stonebrush -------------------- */

/** \page st-stonebrush Brush Stone

This stone is initially invisible. If touched by an actor
having a brush it turns into a "st-rock4".

\subsection stonebrushe Example
\verbatim
set_stone("st-stonebrush", 10,10)
\endverbatim

\image html st-rock4.png
*/
namespace
{
    class Stonebrush : public Stone {
        CLONEOBJ(Stonebrush);
        const char *collision_sound() {return "stone";}
    public:
        Stonebrush() : Stone("st-stonebrush"), state(INVISIBLE) {}
    private:
        enum State { INVISIBLE, BRUSH } state;

        void actor_hit(const StoneContact &sc) {
            if( state == INVISIBLE) {
                if (player::wielded_item_is(sc.actor, "it-brush")) {
                    sound_event ("stonepaint");
                    state = BRUSH;
                    if (server::GameCompatibility == GAMET_PEROXYD) {
                        set_model("st-likeoxydc-open");
                    }
                    else {
                        set_model("st-rock4");
                    }
                }
            }
        }
    };
}

//----------------------------------------
// Break_invisible
//----------------------------------------

/** \page st-break_invisible Brush Stone

This stone is initially invisible. If touched by an actor having a
brush it turns into a "st_stone_break".  This stone can be destroyed
by an actor having a hammer.

\subsection break_invisible Example
\verbatim
set_stone("st-break_invisible", 10,10)
\endverbatim

\image html st-stone_break.png
*/
namespace
{
    class Break_invisible : public Stone {
        CLONEOBJ(Break_invisible);
        const char *collision_sound() {return "stone";}
    public:
        Break_invisible() : Stone("st-break_invisible"), state(INVISIBLE) {}
    private:
        enum State { INVISIBLE, BRUSH, DESTROY };
        State state;
        void actor_hit(const StoneContact &sc) {
            if (state == INVISIBLE) {
                if (player::wielded_item_is(sc.actor, "it-brush")) {
                    sound_event ("stonepaint");
                    state = BRUSH;
                    set_model("st-stone_break");
                }
            }
            else if (state == BRUSH) {
                if (player::wielded_item_is(sc.actor, "it-hammer")) {
                    sound_event ("stonedestroy");
                    state = DESTROY;
                    set_anim("st-stone_break-anim");
                }
            }
        }
        void animcb() {
            if (state == DESTROY)
                KillStone(get_pos());
        }
    };
}

//----------------------------------------
// Invisible Magic
//----------------------------------------

/** \page st-invisible_magic Magic Invisible Stone

This stone is initially invisible, and laserlight can pass through.
If touched by an actor having a magic wand, it will mutate into a
"st-greenbrown" and laserlight is blocked.

\subsection invisible_magice Example
\verbatim
set_stone("st-invisible_magic", 10,10)
\endverbatim

\image html st-greenbrown.png
*/
namespace
{
    class InvisibleMagic : public Stone {
        CLONEOBJ(InvisibleMagic);
        const char *collision_sound() {return "cloth";}
    public:
        InvisibleMagic() : Stone("st-invisible_magic"), state(INVISIBLE) {}
    private:
        enum State { INVISIBLE, STONE } state;

        void actor_hit(const StoneContact &sc) {
            if (state == INVISIBLE) {
                if (player::wielded_item_is(sc.actor, "it-magicwand")) {
                    sound_event ("stonepaint");
                    state = STONE;
                    set_model("st-greenbrown");
                    lasers::MaybeRecalcLight(get_pos());
                }
            }
        }
        bool is_transparent (Direction) const { return state==INVISIBLE; }
    };
}


/* -------------------- Wooden stone -------------------- */

/** \page st-wood Wooden Stone

This stone is movable.  If moved into abyss, water or swamp it builds
a wooden plank.

\subsection woode Example
\verbatim
set_stone("st-wood", 10,10)
\endverbatim

Note: There are two flavors of st-wood which may be specified
by using st-wood1 or st-wood2.

\image html st-wood.png
*/
namespace
{
    class WoodenStone : public Stone {
	CLONEOBJ(WoodenStone);
    public:
        WoodenStone(const char *kind) : Stone(kind) {}

    private:
        void fall() {
            GridPos p = get_pos();
            if (world::IsLevelBorder(p))
                return;

            if (Floor *fl = GetFloor(p)) {
                const string &k = fl->get_kind();
                if (k == "fl-abyss" || k=="fl-water" || k=="fl-swamp") {
                    SetFloor(p, MakeFloor(is_kind("st-wood1") ? "fl-stwood1" : "fl-stwood2"));
                    KillStone(p);
                }
            }
        }

        void message (const string &msg, const Value &) {
            if (msg == "fall")
                fall();
        }

        // in oxyd1 only fall when moving
        void on_move() {
            if (server::GameCompatibility == GAMET_OXYD1)
                fall();
            else
                Stone::on_move();
        }

        // other oxyds versions: fall everytime the floor changes
        void on_floor_change() {
            if (server::GameCompatibility != GAMET_OXYD1)
                fall();
        }
        bool is_movable () const { return true; }
    };

    /*! When st-wood is created it randomly becomes st-wood1 or
      st-wood2. */
    class RandomWoodenStone : public Stone {
    public:
	RandomWoodenStone() : Stone("st-wood") {}
    private:
	Stone *clone() {
	    return new WoodenStone (IntegerRand(0, 1) ? "st-wood1" :  "st-wood2");
	}
	void dispose() {delete this;}
    };
}

//----------------------------------------
// Growing stones used by it-seed
//----------------------------------------
namespace
{
    class WoodenStone_Growing : public Stone {
        CLONEOBJ(WoodenStone_Growing);
    public:
        WoodenStone_Growing() : Stone("st-wood-growing") {}
    private:
        void init_model() { set_anim("st-wood-growing"); }
        void animcb() {
            Stone *st = world::MakeStone ("st-wood");
            world::ReplaceStone (get_pos(), st);
            SendMessage (st, "fall"); // instantly builds a bridge on fl-swamp etc
        }
        void actor_contact(Actor *a) {SendMessage(a, "shatter");}
        void actor_inside(Actor *a) {SendMessage(a, "shatter");}
        void actor_hit(const StoneContact &sc) {SendMessage(sc.actor, "shatter");}
    };

    class GreenbrownStone_Growing : public Stone {
        CLONEOBJ(GreenbrownStone_Growing);
    public:
        GreenbrownStone_Growing() : Stone("st-greenbrown-growing") {}
    private:
        void init_model() { set_anim("st-greenbrown-growing"); }
        void animcb() {
            Stone *st = world::MakeStone("st-greenbrown");
            world::ReplaceStone(get_pos(), st);
        }
        void actor_contact(Actor *a) {SendMessage(a, "shatter");}
        void actor_inside(Actor *a) {SendMessage(a, "shatter");}
        void actor_hit(const StoneContact &sc) {SendMessage(sc.actor, "shatter");}
    };

    class VolcanoStone_Growing : public Stone {
        CLONEOBJ(VolcanoStone_Growing);
    public:
        VolcanoStone_Growing() : Stone("st-volcano-growing") {}
    private:
        void init_model() { set_anim("st-volcano-growing"); }
        void animcb() {
            Stone *st = world::MakeStone("st-volcano_active");
            world::ReplaceStone(get_pos(), st);
        }
        void actor_contact(Actor *a) {SendMessage(a, "shatter");}
        void actor_inside(Actor *a) {SendMessage(a, "shatter");}
        void actor_hit(const StoneContact &sc) {SendMessage(sc.actor, "shatter");}
    };
}


/* -------------------- Scissors stone -------------------- */

/** \page st-scissors Scissors stone

This stone cuts \c all rubber bands attached to an actor that touches
it.

\image html st-scissors
*/
namespace
{
    class ScissorsStone : public Stone {
        CLONEOBJ(ScissorsStone);
        DECL_TRAITS;
        void actor_hit(const StoneContact &sc) {
            world::KillRubberBand (sc.actor, (Stone*)0);
            world::KillRubberBand (sc.actor, (Actor*)0);
            sound_event("scissors");
            set_anim("st-scissors-snip");
        }
        void animcb() {
            set_model("st-scissors");
        }
    public:
        ScissorsStone() 
        {}
    };
    DEF_TRAITS(ScissorsStone, "st-scissors", st_scissors);
}


/* -------------------- Rubberband stone -------------------- */

/** \page st-rubberband Rubberband stone

If hit by a marble, this stone first removes existing connections with
other rubberband stones and then attaches a new elastic between the
marble and itself.  Nothing happens if the marble was already attached
to this particular stone.

This stone can be moved if hit with a magic wand.

\subsection rubberbanda Attributes

- \c length  The natural length of the rubberband (default: 1)
- \c strength The strength of the rubberband (default: 10)

\image html st-rubberband.png
*/
namespace
{
    class RubberBandStone : public Stone {
        CLONEOBJ(RubberBandStone);
        DECL_TRAITS;

        void actor_hit(const StoneContact &sc) {
            double strength = 10.0;
            double length = 1.0;
            double_attrib ("length", &length);
            double_attrib ("strength", &strength);

            world::RubberBandData rbd;
            rbd.strength = strength;
            rbd.length = length;

            if (!world::HasRubberBand (sc.actor, this)) {
                sound_event ("rubberband");
                world::KillRubberBand (sc.actor, (Stone*)0);
                world::AddRubberBand (sc.actor, this, rbd);
            }
//             if (player::wielded_item_is (sc.actor, "it-magicwand"))
            maybe_push_stone (sc);
        }

        void on_impulse (const Impulse& impulse) {
            Actor *a = dynamic_cast<Actor *> (impulse.sender);
            if (a && player::wielded_item_is (a, "it-magicwand"))
                move_stone(impulse.dir);
        }

        

    public:
        RubberBandStone () {
            set_attrib("length", 1.0);
            set_attrib("strength", 10.0);
        }
    };
    DEF_TRAITS(RubberBandStone, "st-rubberband", st_rubberband);
}


/* -------------------- Timer stone -------------------- */

// Attributes:
//
// :interval        seconds between two "ticks"
// :loop
// :action,target   as usual
// :invisible

/** \page st-timer Timer Stone

This stone can be used to trigger periodic events or to trigger one
single event after a certain amount of time.

\subsection timera Attributes

- \b on: 1 if the timer is running
- \b interval:  number of seconds before \b action is performed
- \b loop:      if 1, restart the timer after performing \b action
- \b action, \b target: as usual
- \b invisible : if 1, stone is invisible

\subsection timerm Messages

- \b on, \b off, \b onoff: as usual

\subsection timere Example

\verbatim
-- activate a laser after 5 seconds
set_stone("st-laser", 10,11, {name="laser"})
set_stone("st-timer", 10,10,
          {loop=0, action="onoff", target="laser", interval=5})
\endverbatim
*/
namespace
{
    class TimerStone : public OnOffStone, public TimeHandler
    {
        CLONEOBJ(TimerStone);
    public:
        TimerStone() : OnOffStone("st-timer"), m_signalvalue(1) {
            set_attrib("interval", 1.0);
            set_attrib("loop", 1.0);
            set_attrib("on", 1.0);
            set_attrib("invisible", 0.0);

            // set_on(true);   DOESN'T WORK! calls init_model()
        }
    private:
        int m_signalvalue;

        double get_interval() const {
            double interval = 100;
            double_attrib("interval", &interval);
            return interval;
        }
        void init_model() {
            if (int_attrib("invisible")) {
                set_model("invisible");
            }
            else {
                set_model(is_on() ? "st-timer" : "st-timeroff");
            }
        }

        void on_creation (GridPos p) {
            set_alarm();
            Stone::on_creation (p);
        }

        void set_alarm() {
            if (is_on())
                GameTimer.set_alarm(this, get_interval(), true);
        }

        void alarm() {
            if (is_on()) {
//                 sound::PlaySound("st-timer");
                PerformAction(this, m_signalvalue);
                m_signalvalue = 1-m_signalvalue;
            }
        }

        void notify_onoff (bool newon) {
            if (newon)
                set_alarm();
            else
                GameTimer.remove_alarm (this);
        }
    };
}


/* -------------------- FartStone -------------------- */

/** \page st-fart Fart Stone

The fart stone has the unpleasant habit of "blowing off" when
triggered (by actor contact or signal) and will close all oxyd stones.

\subsection fartm Messages

- \b trigger: as usual

*/

namespace
{
    class FartStone : public Stone {
        CLONEOBJ(FartStone);
        DECL_TRAITS;

        enum State { IDLE, FARTING, BREAKING };
        State state;

        void change_state(State newstate);
        void animcb();
        void actor_hit(const StoneContact &sc);
        void message(const string &m, const Value &val);

        void on_laserhit(Direction) {
            change_state(BREAKING);
        }
    public:
        FartStone() : state(IDLE) 
        {}
    };
    DEF_TRAITS(FartStone, "st-fart", st_fart);
}

void FartStone::change_state(State newstate) 
{
    if (state == newstate)
        return;

    switch (newstate) {
    case IDLE:
        state = IDLE;
        init_model();
        break;
    case FARTING:
    case BREAKING:
        if (state == IDLE) {
            Object *ox = world::GetObjectTemplate("st-oxyd");
            SendMessage(ox, "closeall");
            sound_event("fart");
            if (newstate == BREAKING) {
                sound_event ("stonedestroy");
                set_anim ("st-fartbreak-anim");
            }
            else
                set_anim("st-farting");
            state = newstate;
        }
        break;
    }
}

void FartStone::animcb() 
{
    if (state == FARTING)
        change_state(IDLE);
    else if (state == BREAKING)
        KillStone(get_pos());
}

void FartStone::actor_hit(const StoneContact &sc) 
{
    if (player::wielded_item_is(sc.actor, "it-hammer"))
        change_state(BREAKING);
    else
        change_state(FARTING);
}
void FartStone::message (const string &m, const Value &val) 
{
    if (m == "signal" && to_int(val) != 0)
        change_state(FARTING);
    else if (m=="trigger")
        change_state(FARTING);
    else if (m == "ignite" || m == "expl") 
        change_state(BREAKING);
}




/* -------------------- Thief -------------------- */
namespace
{
    /*! Steals one item from the player's inventory when hit. */
    class ThiefStone : public Stone {
	CLONEOBJ(ThiefStone);
        DECL_TRAITS;

        enum State { IDLE, EMERGING, RETREATING } state;
        Actor *m_affected_actor;
    public:
	ThiefStone();
    private:
	void steal_from_player();

        void actor_hit(const StoneContact &sc);
        // even a slight touch should steal from the actor: 
        void actor_touch(const StoneContact &sc) { actor_hit(sc); }
        void animcb();

        const char *collision_sound() {
            return "cloth";
        }
    };
    DEF_TRAITS(ThiefStone, "st-thief", st_thief);
}

ThiefStone::ThiefStone() 
: state(IDLE),
  m_affected_actor (0)
{
}


void ThiefStone::actor_hit(const StoneContact &sc) {
    if (state==IDLE) {
        set_anim("st-thief-emerge");
        state = EMERGING;
        m_affected_actor = sc.actor;
    }
}

void ThiefStone::animcb() {
    switch (state) {
    case EMERGING:
        steal_from_player();
        state = RETREATING;
        set_anim("st-thief-retreat");
        break;
    case RETREATING:
        state = IDLE;
        init_model();
        break;
    default:
        assert(0);
    }
}

void ThiefStone::steal_from_player() 
{
    if (m_affected_actor && !m_affected_actor->has_shield()) {
        player::Inventory *inv = player::GetInventory(m_affected_actor);
        if (inv && inv->size() > 0) {
            int i = IntegerRand (0, inv->size()-1);
            delete inv->yield_item(i);
            sound_event("thief");
        }
    }
}

// -------------------------
//      ActorImpulseBase
// -------------------------

namespace
{
    class ActorImpulseBase : public Stone {
    public:
        ActorImpulseBase(const char *kind) : Stone(kind), state(IDLE) {
//             set_attrib("force", Value());
        }

    protected:
        virtual void actor_hit (const StoneContact &sc) {
            if (state == IDLE) {
                // actor_hit is called before reflect, but the force added below
                // is applied to actor after the reflection.

                double forcefac = server::BumperForce;
                double_attrib("force", &forcefac);

                V2 vec = normalize(sc.actor->get_pos() - get_pos().center());
                sc.actor->add_force (vec * forcefac);

                sound_event("bumper");
                set_anim("st-actorimpulse-anim");
                state = PULSING;
            }
        }

    private:
        virtual const char *collision_sound() {
            return "";
        }

        void animcb() {
            if (state == PULSING) {
                state = IDLE;
                init_model();
            }
        }

        // Variables
        enum State { IDLE, PULSING, BROKEN };
        State state;
    };


    class ActorImpulseStone : public ActorImpulseBase {
        CLONEOBJ(ActorImpulseStone);

        int m_signalidx;

        void message (const string &msg, const Value &) {
            if (msg == "signal") {
                world::EmitSignalByIndex (this, m_signalidx, 0);
                m_signalidx += 1;
                if (!world::EmitSignalByIndex (this, m_signalidx, 1)) {
                    m_signalidx = 0;
                    world::EmitSignalByIndex (this, m_signalidx, 1);
                }
            } else if (msg == "init") {
                world::EmitSignalByIndex (this, m_signalidx, 1);
            }
        }

    public:
        ActorImpulseStone() : ActorImpulseBase("st-actorimpulse"),
                              m_signalidx(0)
        {}
    };


    class ActorImpulseStoneInvisible : public ActorImpulseBase {
        CLONEOBJ(ActorImpulseStoneInvisible);
    public:
        ActorImpulseStoneInvisible() : ActorImpulseBase("st-actorimpulse_invisible") {}

        void actor_hit(const StoneContact& sc) {
            if (player::wielded_item_is(sc.actor, "it-brush")) {
                Stone *st = MakeStone("st-actorimpulse");
                SetStone(get_pos(), st);
                st->actor_hit(sc);
            }
            else
                ActorImpulseBase::actor_hit(sc);
        }
    };
}

//----------------------------------------
// FakeOxydStone
//----------------------------------------

/** \page st-fakeoxyd Fake Oxyd Stone

These stones look like real Oxyd stones, but they only blink a little
when touched and do not open or have other special abilities.

\image html st-fakeoxyd-blink_0001.png
*/
namespace
{
    class FakeOxydStone : public Stone {
        CLONEOBJ(FakeOxydStone);
    public:
        FakeOxydStone() : Stone("st-fakeoxyd"), state(IDLE) {
            set_attrib("blinking", 0.0);
        }
    private:
        enum State { IDLE, BLINKING } state;
        void actor_hit(const StoneContact &/*sc*/) {
            if (state == IDLE) {
                set_anim("st-fakeoxyd-blink");
                sound_event ("fakeoxyd");
                state = BLINKING;
                set_attrib("blinking", 1.0);
            }
        }
        const char *collision_sound() {
            return "metal";
        }
        void animcb() {
            set_model("st-fakeoxyd");
            state = IDLE;
            set_attrib("blinking", 0.0);
        }
    };
}


/* -------------------- Black Stones -------------------- */
namespace
{
    class BlackWhiteStone : public Stone {
        CLONEOBJ(BlackWhiteStone);
        DECL_TRAITS_ARRAY(8, m_type);
        int m_type;

        BlackWhiteStone(int type) : m_type(type)
        {}

        StoneResponse collision_response(const StoneContact &sc) {
            if (m_type < 4) {
                return (sc.actor->get_attrib("blackball")) ? 
                    STONE_PASS : STONE_REBOUND;
            }
            else {
                return (sc.actor->get_attrib("whiteball")) ? 
                    STONE_PASS : STONE_REBOUND;
            }
        }

        void on_message (const Message &m) {
            if (m.message == "signal" || m.message == "trigger") {
                // toggle between black and white stone
                m_type = (m_type + 4) % 8;
                init_model();
            }
        }

        bool is_floating() const { return true; }
        bool is_transparent (Direction) const { return true; }

    public:
        static void setup() {
            for (int i=0; i<8; ++i)
                RegisterStone (new BlackWhiteStone(i));
        }
    };

    StoneTraits BlackWhiteStone::traits[8] = {
        {"st-black1", st_black1, stf_transparent},
        {"st-black2", st_black2, stf_transparent},
        {"st-black3", st_black3, stf_transparent},
        {"st-black4", st_black4, stf_transparent},
        {"st-white1", st_white1, stf_transparent},
        {"st-white2", st_white2, stf_transparent},
        {"st-white3", st_white3, stf_transparent},
        {"st-white4", st_white4, stf_transparent},
    };

}


/* -------------------- YinYang stones -------------------- */
namespace
{
    class YinYangStone : public Stone {
    public:
        YinYangStone(const char *kind) : Stone(kind)
        {}

    protected:
        void turn_white(const char *stonename = "st-white1") {
            sound_event("yinyang");
            ReplaceStone (get_pos(), MakeStone(stonename));
        }
        void turn_black(const char *stonename = "st-black1") {
            sound_event("yinyang");
            ReplaceStone (get_pos(), MakeStone(stonename));
        }
    };

    class YinYangStone1 : public YinYangStone {
        CLONEOBJ(YinYangStone1);
    public:
        YinYangStone1() : YinYangStone("st-yinyang1") {}

    private:
        void actor_hit(const StoneContact &sc) {
            if      (sc.actor->get_attrib("blackball")) turn_white();
            else if (sc.actor->get_attrib("whiteball")) turn_black();
        }
    };

    class YinYangStone2 : public YinYangStone {
        CLONEOBJ(YinYangStone2);
    public:
        YinYangStone2() : YinYangStone("st-yinyang2") {}
    private:
        void actor_hit(const StoneContact &sc) {
            if      (sc.actor->get_attrib("blackball")) turn_black();
            else if (sc.actor->get_attrib("whiteball")) turn_white();
        }
    };


    /*! A Per.Oxyd compatible YinYang stone that must be activated
      with a magic wand or a brush. */
    class YinYangStone3 : public YinYangStone {
        CLONEOBJ(YinYangStone3);
    public:
        YinYangStone3() : YinYangStone("st-yinyang3") {}
    private:
        void actor_hit(const StoneContact &sc) {
            if (player::wielded_item_is(sc.actor, "it-magicwand") ||
                player::wielded_item_is(sc.actor, "it-brush"))
            {
                if      (sc.actor->get_attrib("blackball")) 
                    turn_white("st-white4");
                else if (sc.actor->get_attrib("whiteball")) 
                    turn_black("st-black4");
            }
        }
    };
}


/* -------------------- BombStone -------------------- */

namespace
{
    /*! This stone add a bomb to the player's inventory when touched. */
    class BombStone : public Stone {
        CLONEOBJ(BombStone);
        const char *collision_sound() {return "stone";}
    public:
        BombStone() : Stone("st-bombs"),state(IDLE) {}
    private:
        enum State { IDLE, BREAK };
        State state;
        void actor_hit(const StoneContact &sc);
        void change_state (State newstate) {
            if (state == IDLE && newstate==BREAK) {
                state = newstate;
                sound_event ("stonedestroy");
                set_anim("st-bombs-anim");
            }
        }
        void animcb() {
            assert(state == BREAK);
            GridPos p = get_pos();
            SendExplosionEffect(p, EXPLOSION_BOMBSTONE);
            KillStone(p);
            SetItem(p, it_explosion1);
        }
        void BombStone::message(const string &msg, const Value &) {
            if (msg =="expl" || msg =="bombstone")
                change_state(BREAK);
        }
    };
}

void BombStone::actor_hit(const StoneContact &sc) {
    if (player::Inventory *inv = player::GetInventory(sc.actor)) {
        if (!inv->is_full()) {
            Item *it = MakeItem("it-blackbomb");
            inv->add_item(it);
        }
    }
}


/* -------------------- MagicStone -------------------- */
namespace
{
    class MagicStone : public Stone {
        CLONEOBJ(MagicStone);
        DECL_TRAITS;
        void actor_hit(const StoneContact &sc) {
            if (sc.actor->get_attrib("player") && 
                sc.actor->get_vel() * sc.normal < -4)
            {
                KillStone(get_pos());
                client::Msg_ShowText ("We don't sell books..", false, 2.0);
            }
        }
    public:
        MagicStone()
        {}
    };
    DEF_TRAITS(MagicStone, "st-magic", st_magic);
}


/* -------------------- DeathStone -------------------- */

/** \page st-death Death's Head Stone

Simply kills all actors that touch it (except for actors that are
immune to these stones).

\image html st-death.png
*/
namespace
{
    class DeathStone : public Stone {
        CLONEOBJ(DeathStone);
        DECL_TRAITS;
        bool active;
      
        void actor_hit(const StoneContact &sc) {
            SendMessage(sc.actor, "shatter");
            if (!active) {
                active=true;
                set_anim("st-death-anim");
            }
        }

        // even a slight touch should shatter the actor: 
        void actor_touch(const StoneContact &sc) { actor_hit(sc); }

    protected:
        void animcb() { set_model("st-death"); active=false; }
    public:
        DeathStone() : active(false)
        {}
    };
    DEF_TRAITS(DeathStone, "st-death", st_death);
}


/* -------------------- Invisible DeathStone -------------------- */

/** \page st-death_invisible Death's Head Stone invivible

Simply kills all actors that touch it (except for actors that are
immune to these stones). This variant is invisible.

\image html st-death.png
*/
namespace
{
    class DeathStoneInvisible : public DeathStone {
        CLONEOBJ(DeathStoneInvisible);
        DECL_TRAITS;

        bool visible; // seen through glasses

        void set_visible_model() {
            set_model(visible ? "st-death" : "st-death_invisible");
        }

        void animcb() {
            DeathStone::animcb();
            set_visible_model();
        }

        void message(const string& msg, const Value &val) {
            if (msg == "glasses") {
                if (to_int(val)) {
                    if (!visible) {
                        visible = true;
                        set_visible_model();
                    }
                }
                else {
                    if (visible) {
                        visible = false;
                        set_visible_model();
                    }
                }
            }
        }
    public:
        DeathStoneInvisible() : visible(false) {}
    };
    DEF_TRAITS(DeathStoneInvisible, "st-death_invisible", st_death_invisible);
}


/* -------------------- Brake stone -------------------- */

/** \page st-brake Brake

Blocks bolder stones and other movable stones.  Can be picked up.

\image html st-brake.png
*/

namespace
{
    class BrakeStone : public Stone {
        CLONEOBJ(BrakeStone);
    public:
        BrakeStone() : Stone("st-brake") {}

        void on_creation (GridPos p) {
            Stone::on_creation(p);

            Item    *it = GetItem(p);
            if (it && it->is_kind("it-blocker")) {
                KillItem(p);
//                sound_event ("explosion1");
            }
        }

        StoneResponse collision_response(const StoneContact &/*sc*/) {
            return STONE_PASS;
        }

        void actor_inside(Actor *a) {
            const double BRAKE_RADIUS = 0.3;
            GridPos      p            = get_pos();
            double       dist         = length(a->get_pos() - p.center());

            if (dist < BRAKE_RADIUS) {
                player::PickupStoneAsItem(a, p);
            }
        }

        void explode() {
            GridPos p = get_pos();
            KillStone(p);
            SetItem(p, it_explosion1);
        }

        void on_laserhit(Direction) {
            explode();
        }

        void message(const string &msg, const Value &) {
            if (msg == "expl") {
                explode();
            }
        }

        bool is_sticky(const Actor *) const 
        { return false; }
    };
}


/* -------------------- Disco stones -------------------- */
namespace
{
    class DiscoStone : public Stone {
        CLONEOBJ(DiscoStone);
    public:
        DiscoStone(const char *kind) : Stone(kind) {}

        StoneResponse collision_response(const StoneContact &) {
            return STONE_PASS;
        }

        virtual void lighten() {}
        virtual void darken() {}
    protected:
        static void visit_lighten(GridPos p) {
            if (DiscoStone *st = dynamic_cast<DiscoStone*>(GetStone(p)))
                st->lighten();
        }
        static void visit_darken(GridPos p) {
            if (DiscoStone *st = dynamic_cast<DiscoStone*>(GetStone(p)))
                st->darken();
        }

    private:
        bool is_floating() const { return true; }

        void message(const string &msg, const Value &val) {
            if (msg == "signal") {
                int ival = to_int (val);
                if (ival > 0)
                    lighten();
                else
                    darken();
            }
            else if (msg == "lighten")
                lighten();
            else if (msg == "darken")
                darken();
        }
    };
    class DiscoLight : public DiscoStone {
        CLONEOBJ(DiscoLight);
        virtual void darken() {
            GridPos p = get_pos();
            SetStone (p, MakeStone("st-disco-medium"));
            visit_darken (move(p, NORTH));
            visit_darken (move(p, EAST));
            visit_darken (move(p, SOUTH));
            visit_darken (move(p, WEST));
        }
    public:
        DiscoLight() : DiscoStone("st-disco-light") {}
    };
    class DiscoMedium : public DiscoStone {
        CLONEOBJ(DiscoMedium);
    public:
        DiscoMedium() : DiscoStone("st-disco-medium") {}
        virtual void lighten() {
            GridPos p = get_pos();
            SetStone (p, MakeStone("st-disco-light"));
            visit_lighten (move(p, NORTH));
            visit_lighten (move(p, EAST));
            visit_lighten (move(p, SOUTH));
            visit_lighten (move(p, WEST));
        }
        virtual void darken() {
            GridPos p = get_pos();
            SetStone (p, MakeStone("st-disco-dark"));
            visit_darken (move(p, NORTH));
            visit_darken (move(p, EAST));
            visit_darken (move(p, SOUTH));
            visit_darken (move(p, WEST));
        }
    };

    class DiscoDark : public DiscoStone {
        CLONEOBJ(DiscoDark);
        virtual void lighten() {
            GridPos p = get_pos();
            SetStone (p, MakeStone("st-disco-medium"));
            visit_lighten (move(p, NORTH));
            visit_lighten (move(p, EAST));
            visit_lighten (move(p, SOUTH));
            visit_lighten (move(p, WEST));
        }
        virtual void darken() {}
    public:
        DiscoDark() : DiscoStone("st-disco-dark") {}
    };
}


/* -------------------- Knight stone -------------------- */
namespace
{
    class Knight : public Stone {
        CLONEOBJ(Knight);
        DECL_TRAITS;

        int subtype;
        enum {MIN_SUBTYPE=1, MAX_SUBTYPE=5};

        StoneResponse collision_response(const StoneContact &) {
            return (subtype == MAX_SUBTYPE) ? STONE_PASS : STONE_REBOUND;
        }
        void actor_hit(const StoneContact &sc)
        {
            if (subtype != MAX_SUBTYPE) {
                if (player::wielded_item_is (sc.actor, "it-sword")) {
                    subtype += 1;
                    if (subtype == MAX_SUBTYPE) {
                        client::Msg_ShowText ("All right, we'll call it a draw", false, 4.0);
		    }
                    init_model();
                } else {
                    SendMessage(sc.actor, "shatter");
                }
            }
        }
        void init_model() {
            set_model(px::strf("st-knight%d", subtype));
        }
        bool is_floating() const { return subtype == MAX_SUBTYPE; }
    public:
        Knight() : subtype (MIN_SUBTYPE) {}
    };
    DEF_TRAITS(Knight, "st-knight", st_knight);
}


/* -------------------- Functions -------------------- */

void world::DefineSimpleStone(const std::string &kind, 
                              const std::string &sound,
                              int hollow, int glass)
{
    Register(new SimpleStone(kind, sound, hollow, glass));
}

void world::DefineSimpleStoneMovable(const std::string &kind, 
                                     const std::string &sound, 
                                     int glass)
{
    Register(new SimpleStoneMovable(kind, sound, glass));
}

void stones::Init_simple()
{
    Register(new ActorImpulseStone);
    Register(new ActorImpulseStoneInvisible);

    BlackWhiteStone::setup();

    Register(new BlockStone);
    Register(new BombStone);
    Register(new BrakeStone);

    Register(new Break_acblack);
    Register(new Break_acwhite);
    Register(new Break_bolder);
    Register(new Break_invisible);

    Register(new BrickMagic);

    RegisterStone (new ChameleonStone);

    RegisterStone (new DeathStone);
    RegisterStone (new DeathStoneInvisible);
    Register(new DiscoLight);
    Register(new DiscoMedium);
    Register(new DiscoDark);
    Register(new DummyStone);
    RegisterStone (new EasyModeStone);
    Register(new FakeOxydStone);
    Register(new FartStone);
    Register(new Grate1);
    Register(new Grate2);
    Register(new Grate3);
    Register(new InvisibleMagic);
    Register(new Knight);
    Register(new LaserBreakable);
    Register(new MagicStone);
    Register(new RubberBandStone);
    Register(new ScissorsStone);
    Register(new Stone_break("st-stone_break"));
    Register(new Stone_break("st-rock3_break"));
    Register(new Stone_break("st-break_gray"));
    Register(new Stone_movebreak);
    Register(new Stonebrush);
    Register(new SwapStone);

    Register(new ThiefStone);
    Register(new TimerStone);
    Register(new Window);

    Register(new RandomWoodenStone); // random flavor
    Register(new WoodenStone("st-wood1")); // horizontal planks
    Register(new WoodenStone("st-wood2")); // vertical planks
    Register(new WoodenStone_Growing);
    Register(new GreenbrownStone_Growing);
    Register(new VolcanoStone_Growing);

    Register(new YinYangStone1);
    Register(new YinYangStone2);
    Register(new YinYangStone3);
}
