----------------------------------------------------------------------------------
-- Company: UNC Charlotte
-- Engineer: Dejan Rasuo, Gabriel Van Dreel, & Hassan Allabad
-- 
-- Create Date: 08/25/2019 04:12:54 PM
-- Design Name: Encoder
-- Module Name: task3 - Behavioral
-- Project Name: Project 1
-- Target Devices: 
-- Tool Versions: 
-- Description: This task acts as an encoder for a seven segment display that takes a four bit unsigned binary value
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

entity task3 is
    port(   hex_in: in std_logic_vector(3 downto 0);
            a: out std_logic;
            b: out std_logic;
            c: out std_logic;
            d: out std_logic;
            e: out std_logic;
            f: out std_logic;
            g: out std_logic);
end task3;

architecture Behavioral of task3 is

signal output: std_logic_vector(6 downto 0);

begin

process(hex_in)
begin
    case hex_in is
        when "0000" => output <= "1111110";
        when "0001" => output <= "0110000";
        when "0010" => output <= "1101101";
        when "0011" => output <= "1111001";
        when "0100" => output <= "0110011";
        when "0101" => output <= "1011011";
        when "0110" => output <= "1011111";
        when "0111" => output <= "1110000";
        when "1000" => output <= "1111111";
        when "1001" => output <= "1111011";       
        when "1010" => output <= "1110111";
        when "1011" => output <= "0011111";
        when "1100" => output <= "1001110";
        when "1101" => output <= "0111101";
        when "1110" => output <= "1001111";
        when "1111" => output <= "1000111";
        when others => output <= "0000000";
    end case;
end process;

a <= output(6);
b <= output(5);
c <= output(4);
d <= output(3);
e <= output(2);
f <= output(1);
g <= output(0);

end Behavioral;
