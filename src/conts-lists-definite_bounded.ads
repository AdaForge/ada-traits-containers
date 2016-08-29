------------------------------------------------------------------------------
--                     Copyright (C) 2015-2016, AdaCore                     --
--                                                                          --
-- This library is free software;  you can redistribute it and/or modify it --
-- under terms of the  GNU General Public License  as published by the Free --
-- Software  Foundation;  either version 3,  or (at your  option) any later --
-- version. This library is distributed in the hope that it will be useful, --
-- but WITHOUT ANY WARRANTY;  without even the implied warranty of MERCHAN- --
-- TABILITY or FITNESS FOR A PARTICULAR PURPOSE.                            --
--                                                                          --
-- As a special exception under Section 7 of GPL version 3, you are granted --
-- additional permissions described in the GCC Runtime Library Exception,   --
-- version 3.1, as published by the Free Software Foundation.               --
--                                                                          --
-- You should have received a copy of the GNU General Public License and    --
-- a copy of the GCC Runtime Library Exception along with this program;     --
-- see the files COPYING3 and COPYING.RUNTIME respectively.  If not, see    --
-- <http://www.gnu.org/licenses/>.                                          --
--                                                                          --
------------------------------------------------------------------------------

--  Bounded controlled lists of constrained elements

pragma Ada_2012;
with Ada.Finalization;
with Conts.Elements.Definite;
with Conts.Lists.Generics;
with Conts.Lists.Storage.Bounded;

generic
   type Element_Type is private;
   with procedure Free (E : in out Element_Type) is null;
package Conts.Lists.Definite_Bounded is

   pragma Assertion_Policy
      (Pre => Suppressible, Ghost => Suppressible, Post => Ignore);

   package Elements is new Conts.Elements.Definite
     (Element_Type, Free => Free);
   package Storage is new Conts.Lists.Storage.Bounded
      (Elements            => Elements.Traits,
       Container_Base_Type => Ada.Finalization.Controlled);
   package Lists is new Conts.Lists.Generics (Storage.Traits);

   subtype Cursor is Lists.Cursor;
   subtype List is Lists.List;

   package Cursors renames Lists.Cursors;
   package Maps renames Lists.Maps;

end Conts.Lists.Definite_Bounded;
