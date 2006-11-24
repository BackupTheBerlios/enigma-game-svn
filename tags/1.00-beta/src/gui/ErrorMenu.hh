/*
 * Copyright (C) 2006 Ronald Lamprecht
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
 * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
 *
 */

#ifndef GUI_ERRORMENU_HH_INCLUDED
#define GUI_ERRORMENU_HH_INCLUDED


#include "gui/Menu.hh"
#include "ecl.hh"

namespace enigma { namespace gui {
    class ErrorMenu : public Menu {
    public:
        ErrorMenu (std::string message, std::string buttonTitle);
    private:
        bool on_event           (const SDL_Event &e);
        void on_action          (gui::Widget *w);
        void draw_background    (ecl::GC &gc);
    
        std::string  text;
        gui::Widget *quit;
    };
}} // namespace enigma::gui
#endif // GUI_ERRORMENU_HH_INCLUDED

