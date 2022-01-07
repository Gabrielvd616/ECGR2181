----------------------------------------------------------------------------------
-- Company: UNC Charlotte
-- Engineer: Dejan Rasuo, Gabriel Van Dreel, & Hassan Allabad
-- 
-- Create Date: 08/25/2019 05:15:16 PM
-- Design Name: Encoder Test Bench
-- Module Name: task3_tb - Behavioral
-- Project Name: Project 1
-- Target Devices: 
-- Tool Versions: 
-- Description: This task defines the simulation of an encoder for a seven segment display that takes a four bit unsigned binary value
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity task3_tb is
--  Port ( );
end task3_tb;

architecture Behavioral of task3_tb is

component task3
port(   hex_in: in std_logic_vector(3 downto 0);
        a, b, c, d, e, f, g: out std_logic);
end component;

signal hex_in: std_logic_vector(3 downto 0);
signal a, b, c, d, e, f, g: std_logic;

signal counter: unsigned(3 downto 0) := "0000";

signal sw: std_logic_vector(3 downto 0);

begin

uut: task3 port map(hex_in => hex_in, a => a, b => b, c => c, d => d, e => e, f => f, g => g); 

sw <= std_logic_vector(counter);

hex_in <= sw;

tb: process
begin
    wait for 20 ns;
    counter <= counter + 1;
end process tb;

end Behavioral;
