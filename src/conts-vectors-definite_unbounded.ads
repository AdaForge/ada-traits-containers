--
--  Copyright (C) 2015-2016, AdaCore
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

--  Unbounded vectors of constrained elements.
--  Compared with standard Ada containers, this is saving half of the memory
--  allocations, so much more efficient in general.

pragma Ada_2012;
with Conts.Elements.Definite;
with Conts.Vectors.Generics;
with Conts.Vectors.Storage.Unbounded;

generic
   type Index_Type is (<>);
   type Element_Type is private;
   type Container_Base_Type is abstract tagged limited private;
   with procedure Free (E : in out Element_Type) is null;
package Conts.Vectors.Definite_Unbounded is

   pragma Assertion_Policy
      (Pre => Suppressible, Ghost => Suppressible, Post => Ignore);

   package Elements is new Conts.Elements.Definite
     (Element_Type, Free => Free);
   package Storage is new Conts.Vectors.Storage.Unbounded
      (Elements            => Elements.Traits,
       Container_Base_Type => Container_Base_Type,
       Resize_Policy       => Conts.Vectors.Resize_1_5);
   package Vectors is new Conts.Vectors.Generics (Index_Type, Storage.Traits);

   subtype Vector is Vectors.Vector;
   subtype Cursor is Vectors.Cursor;
   subtype Extended_Index is Vectors.Extended_Index;

   package Cursors renames Vectors.Cursors;
   package Maps renames Vectors.Maps;

   procedure Swap
      (Self : in out Cursors.Forward.Container; Left, Right : Index_Type)
      renames Vectors.Swap;

end Conts.Vectors.Definite_Unbounded;
