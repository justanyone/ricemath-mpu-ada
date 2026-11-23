with Math_Prime_Util.Random;

--  Operating-system boundary for entropy.c: get_entropy_bytes.
private package Math_Prime_Util.Random_Entropy with SPARK_Mode => Off is
   --  Fill bytes from the system source; failure raises Random.Entropy_Error.
   procedure Fill (Data : out Random.Byte_Array);
end Math_Prime_Util.Random_Entropy;
