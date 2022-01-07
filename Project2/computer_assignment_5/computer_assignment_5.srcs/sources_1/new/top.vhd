----------------------------------------------------------------------------------
-- Company: UNC Charlotte
-- Engineer: Dejan Rasuo, Gabriel Van Dreel, & Hassan Allabad
-- 
-- Create Date: 11/16/2019 08:16:15 PM
-- Design Name: Binary Guessing Game
-- Module Name: top - Behavioral
-- Project Name: Project 2
-- Target Devices: 
-- Tool Versions: 
-- Description: This is an implementation of two buttons that work with eight switches as binary inputs for a guessing game that outputs high on the fifteenth LED when the correct combination is guessed
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top is
    port(   sw: in std_logic_vector(7 downto 0);
            btnR: in std_logic;
            btnL: in std_logic;
            clk: in std_logic;
            led: out std_logic_vector(15 downto 15)); --Does not run unless it is defined as a standard_logic_vector
end top;

architecture Behavioral of top is

--Imports debounce
component debounce is
    port(   clk_100m: in std_logic;
            sw: in std_logic;
            sglPulse: out std_logic;
            sig: out std_logic);
end component;

--Declares signal for computation
signal num: std_logic_vector(7 downto 0) := "00000000";

--Declares signals for components
signal right: std_logic := '0'; --Can simplify declarations
signal left: std_logic := '0';
signal output: std_logic_vector(15 downto 15) := "0"; --Datatype fixed

begin

--Implements two debounces
d1: debounce port map(
    clk_100m => clk,
    sw => btnR,
    sglPulse => right,
    sig => open);

d2: debounce port map(
    clk_100m => clk,
    sw => btnL,
    sglPulse => left,
    sig => open);

led <= output;

process(clk)
begin
    if(rising_edge(clk)) then
        if(right = '1') then
            num <= sw;
        elsif(left = '1') then
            if(sw = num) then
                output <= "1"; --Datatype fixed
            else
                output <= "0"; --Datatype fixed
            end if;
        end if;
    end if;
end process;

end Behavioral;
