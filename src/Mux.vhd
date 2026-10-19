------------------------------------------------------------
-- Name       : Solomon Ewusi
-- Student ID : N01659373
-- Course     : CENG 356 - Computer Systems Architecture
-- Lab        : Lab 4 - VHDL Design of ALU and its FPGA Implementation
-- File       : Mux.vhd
-- Description: 8-to-1 multiplexer used by the ALU to select the result
-- Date       : October 19, 2026
------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

-- This multiplexer accepts 8 6-bit data inputs and a 3-bit
-- control input, SEL. Based on the decimal equivalent of the
-- control input, one data input is selected and connected to
-- the output port, Y.
-- In this design, let's not generate the compliment of Y.

entity Mux is
  generic (n : integer);
  port (D0   : in std_logic_vector((n-1) downto 0);
        D1   : in std_logic_vector((n-1) downto 0);
        D2   : in std_logic_vector((n-1) downto 0);
        D3   : in std_logic_vector((n-1) downto 0);
        D4   : in std_logic_vector((n-1) downto 0);
        D5   : in std_logic_vector((n-1) downto 0);
        D6   : in std_logic_vector((n-1) downto 0);
        D7   : in std_logic_vector((n-1) downto 0);
        SEL  : in std_logic_vector(2 downto 0);

        Y    : out std_logic_vector((n-1) downto 0));
end Mux;

architecture RTL of Mux is
begin

-- Complete the following concurrent statement.
-- Note, Y is a function of 8 data inputs plus
-- the select input, SEL.

   Y <= D0 when SEL = "000" else    -- 000: A + B
        D1 when SEL = "001" else    -- 001: A - B
        D2 when SEL = "010" else    -- 010: A AND B
        D3 when SEL = "011" else    -- 011: A OR B
        D4 when SEL = "100" else    -- 100: A XOR B
        D5 when SEL = "101" else    -- 101: NOT A
        D6 when SEL = "110" else    -- 110: shift A right by one bit
        D7;                         -- 111: shift A left by one bit
end RTL;
