----------------------------------------------------------------------------------
-- Company: UNC Charlotte
-- Engineer: Dejan Rasuo, Gabriel Van Dreel, & Hassan Allabad
-- 
-- Create Date: 08/25/2019 02:15:15 PM
-- Design Name: Combinational Logic
-- Module Name: task2 - Behavioral
-- Project Name: Project 1
-- Target Devices: 
-- Tool Versions: 
-- Description: This task acts as a combinational logic system that takes four binary inputs
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

entity task2 is
    port(   a: in std_logic;
            b: in std_logic;
            c: in std_logic;
            d: in std_logic;
            f: out std_logic;
            g: out std_logic;
            h: out std_logic);
end task2;

architecture Behavioral of task2 is

begin

    f <= not(not((a and not(b) and not(d)) xor ((not(a) and b) or not(b and c))) or (not(a) and c and d and ((b and not(c)) or (a and not(b) and c and not(d)) or (not(a) and c and not(d)))));
    g <= not(a) or (b and not(c)) or (not(b) and d);
    h <= (not(a) and not(b) and not(c) and not(d)) or (not(a) and not(b) and not(c) and d) or (not(a) and not(b) and c and not(d)) or (not(a) and not(b) and c and d) or (not(a) and b and not(c) and not(d)) or (not(a) and b and not(c) and d) or (not(a) and b and c and not(d)) or (not(a) and b and c and d) or (a and b and not(c) and not(d)) or (a and b and not(c) and d) or (a and not(b) and not(c) and d) or (a and not(b) and c and d);

end Behavioral;
