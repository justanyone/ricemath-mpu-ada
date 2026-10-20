with Ada.Containers.Vectors;
with Interfaces;

--  Public result container for the native sieve. A library-level instance
--  keeps GNAT 16 reference finalizers available to separate client units.
package Math_Prime_Util.Sieve_Vectors is new Ada.Containers.Vectors
  (Index_Type => Natural, Element_Type => U64, "=" => Interfaces."=");
