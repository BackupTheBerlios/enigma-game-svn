/*
 * Copyright (C) 2002,2003 Daniel Heck
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
 * $Id: editor.hh,v 1.3 2003/07/17 20:18:03 dheck Exp $
 */
#ifndef EDITOR_HH
#define EDITOR_HH

#include <string>

namespace editor 
{
    void Run();
    void DefineFloorGroup (const char *name, const char *descr,
                           int nentries, const char **entries);

    void DefineItemGroup (const char *name, const char *descr,
                          int nentries, const char **entries);

    void DefineStoneGroup (const char *name, const char *descr,
                           int nentries, const char **entries);
}

#endif
