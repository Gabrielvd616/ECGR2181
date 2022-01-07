----------------------------------------------------------------------------------
-- Company: UNC Charlotte
-- Engineer: Dejan Rasuo, Gabriel Van Dreel, & Hassan Allabad
-- 
-- Create Date: 08/25/2019 01:19:46 PM
-- Design Name: One Bit Adder Test Bench
-- Module Name: task1_tb - Behavioral
-- Project Name: Project 1
-- Target Devices: 
-- Tool Versions: 
-- Description: This task defines the simulation of a one bit adder that may be used to form a multibit adder
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
use IEEE.NUMERIC_STD.ALL; --Uncommented for supporting unsigned values

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity task1_tb is
--  Port ( );
end task1_tb;

architecture Behavioral of task1_tb is

component task1
port(   a, b, cin: in std_logic;
        sum, cout: out std_logic);
end component;

signal a, b, cin, sum, cout: std_logic;

signal counter: unsigned(2 downto 0) := "000";

signal sw: std_logic_vector(2 downto 0);

begin

uut: task1 port map(a => a, b => b, cin => cin, sum => sum, cout => cout);

sw <= std_logic_vector(counter);

a <= sw(2);
b <= sw(1);
cin <= sw(0);

tb: process
begin
    wait for 20 ns;
    counter <= counter + 1;
end process tb;

end Behavioral;
