----------------------------------------------------------------------------------
-- Company: UNC Charlotte
-- Engineer: Dejan Rasuo, Gabriel Van Dreel, & Hassan Allabad
-- 
-- Create Date: 08/25/2019 02:59:15 PM
-- Design Name: Combinational Logic Test Bench
-- Module Name: task2_tb - Behavioral
-- Project Name: Project 1
-- Target Devices: 
-- Tool Versions: 
-- Description: This task defines the simulation of a combinational logic system that takes four binary inputs
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

entity task2_tb is
--  Port ( );
end task2_tb;

architecture Behavioral of task2_tb is

component task2
port(   a, b, c, d: in std_logic;
        f, g, h: out std_logic);
end component;

signal a, b, c, d, f, g, h: std_logic;

signal counter: unsigned(3 downto 0) := "0000";

signal sw: std_logic_vector(3 downto 0);

begin

uut: task2 port map(a => a, b => b, c => c, d => d, f => f, g => g, h => h);

sw <= std_logic_vector(counter);

a <= sw(3);
b <= sw(2);
c <= sw(1);
d <= sw(0);

tb: process
begin
    wait for 20 ns;
    counter <= counter + 1;
end process tb;

end Behavioral;
