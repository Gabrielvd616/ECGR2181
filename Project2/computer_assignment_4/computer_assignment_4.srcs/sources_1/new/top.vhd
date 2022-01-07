----------------------------------------------------------------------------------
-- Company: UNC Charlotte
-- Engineer: Dejan Rasuo, Gabriel Van Dreel, & Hassan Allabad
-- 
-- Create Date: 11/16/2019 06:05:22 PM
-- Design Name: Two's Complement Binary Converter
-- Module Name: top - Behavioral
-- Project Name: Project 2
-- Target Devices: 
-- Tool Versions: 
-- Description: This is an implementation of four encoders that display the signed decimal equivalent of a two's complement binary value inputted using eight switches for input and two buttons that either enter or clear the binary input.
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

entity top is
    port(   sw: in std_logic_vector(7 downto 0);
            btnR: in std_logic;
            btnL: in std_logic;
            clk: in std_logic;
            seg: out std_logic_vector(6 downto 0);
            dp: out std_logic;
            an: out std_logic_vector(3 downto 0);
            led: out std_logic_vector(7 downto 0));
end top;

architecture Behavioral of top is

--Imports encoder
component encoder is
    port(   hex_in: in std_logic_vector(3 downto 0);
            a: out std_logic; --Could simplify signal and I/O declarations
            b: out std_logic;
            c: out std_logic;
            d: out std_logic;
            e: out std_logic;
            f: out std_logic;
            g: out std_logic);
end component;

--Imports ssd_muxer
component ssd_muxer is
    port(   a_in: in std_logic_vector(3 downto 0);
            b_in: in std_logic_vector(3 downto 0);
            c_in: in std_logic_vector(3 downto 0);
            d_in: in std_logic_vector(3 downto 0);
            e_in: in std_logic_vector(3 downto 0);
            f_in: in std_logic_vector(3 downto 0);
            g_in: in std_logic_vector(3 downto 0);
            decp0_in: in std_logic; --Could be simplified t0 decp_in in std_logic_vector(3 downto 0)
            decp1_in: in std_logic;
            decp2_in: in std_logic;
            decp3_in: in std_logic;
            seg_out: out std_logic_vector(6 downto 0);
            dp_out: out std_logic;
            an_out: out std_logic_vector(3 downto 0);
            clk: in std_logic);
end component;

--Imports debounce
component debounce is
    port(   clk_100m: in std_logic;
            sw: in std_logic;
            sglPulse: out std_logic;
            sig: out std_logic);
end component;

--Declares signals for entering and clearing input
signal clr: std_logic; --Could simplify signal and I/O declarations
signal en: std_logic;

--Declares signals for computation
signal accumulator: std_logic_vector(7 downto 0);
signal h0: std_logic_vector(3 downto 0);
signal h1: std_logic_vector(3 downto 0);
signal h2: std_logic_vector(3 downto 0);
signal h3: std_logic_vector(3 downto 0);

--Declares signals for components
signal w0: std_logic_vector(3 downto 0);
signal w1: std_logic_vector(3 downto 0);
signal w2: std_logic_vector(3 downto 0);
signal w3: std_logic_vector(3 downto 0);
signal w4: std_logic_vector(3 downto 0);
signal w5: std_logic_vector(3 downto 0);
signal w6: std_logic_vector(3 downto 0);

begin

--Implements two debounces
d1: debounce port map(
    clk_100m => clk, --Can be condensed
    sw => btnR,
    sglPulse => clr,
    sig => open);

d2: debounce port map(
    clk_100m => clk,
    sw => btnL,
    sglPulse => en,
    sig => open);

--Connects the switches to the LEDs
led <= sw;

--Resets input or transfers input
process(clr, en)
begin
    if(clr = '1') then
        accumulator <= "00000000";
    elsif(en = '1') then
        accumulator <= sw;
    end if;
end process;

--2s complement conversion
process(accumulator)
variable tempNum, a, b, c: integer := 0;
begin
    tempNum := abs(to_integer(signed(accumulator)));
    
    a := tempNum / 100; --Seven segment hundreds place
    b := tempNum mod 100 / 10; --Seven segment tens place
    c := tempNum mod 100 mod 10 / 1; --Seven segment ones place
    
    if(accumulator(7) = '1') then --Negative number (-)
        if(a = 0 and b = 0) then
            h0 <= "1110";
            h1 <= "1110";
            h2 <= "1111";
        elsif(a = 0) then
            h0 <= "1110";
            h1 <= "1111";
            h2 <= std_logic_vector(to_unsigned(b, 4));
        else
            h0 <= "1111";
            h1 <= std_logic_vector(to_unsigned(a, 4));
            h2 <= std_logic_vector(to_unsigned(b, 4));
        end if;
    else --Positive number (+)
        h0 <= "1110";
        if(a = 0) then
            h1 <= "1110";
        else
            h1 <= std_logic_vector(to_unsigned(a, 4));
        end if;
        
        if(a = 0 and b = 0) then
            h2 <= "1110";
        else
            h2 <= std_logic_vector(to_unsigned(b, 4));
        end if;
    end if;
    
    h3 <= std_logic_vector(to_unsigned(c, 4));

end process;

--Implements the seven segment display multiplexer
mux1: ssd_muxer port map(
    a_in => w0,
    b_in => w1,
    c_in => w2,
    d_in => w3,
    e_in => w4,
    f_in => w5,
    g_in => w6,
    decp0_in => '0',
    decp1_in => '0',
    decp2_in => '0',
    decp3_in => '0',
    clk => clk,
    seg_out => seg,
    dp_out => dp,
    an_out => an);

--Implements four encoders
enc1: encoder port map( --Potentially use for generator statement
    hex_in => h0, --To make for generator statement h0, h1, h2, and h3 need to be augmented as one signal
    a => w0(3),
    b => w1(3),
    c => w2(3),
    d => w3(3),
    e => w4(3),
    f => w5(3),
    g => w6(3));

enc2: encoder port map(
    hex_in => h1,
    a => w0(2),
    b => w1(2),
    c => w2(2),
    d => w3(2),
    e => w4(2),
    f => w5(2),
    g => w6(2));

enc3: encoder port map(
    hex_in => h2,
    a => w0(1),
    b => w1(1),
    c => w2(1),
    d => w3(1),
    e => w4(1),
    f => w5(1),
    g => w6(1));

enc4: encoder port map(
    hex_in => h3,
    a => w0(0),
    b => w1(0),
    c => w2(0),
    d => w3(0),
    e => w4(0),
    f => w5(0),
    g => w6(0));

end Behavioral;
