----------------------------------------------------------------------------------
-- Company: UNC Charlotte
-- Engineer: Dejan Rasuo, Gabriel Van Dreel, & Hassan Allabad
-- 
-- Create Date: 11/16/2019 04:52:58 PM
-- Design Name: Seven Segment Display Encoder
-- Module Name: top - Behavioral
-- Project Name: Project 2
-- Target Devices: 
-- Tool Versions: 
-- Description: This task is an implementation of four encoders to operate a 4-digit seven segment display given switches as inputs to the encoders
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
    port(   sw: in std_logic_vector(15 downto 0);
            clk: in std_logic;
            seg: out std_logic_vector(6 downto 0);
            dp: out std_logic;
            an: out std_logic_vector(3 downto 0);
            led: out std_logic_vector(15 downto 0));
end top;

architecture Behavioral of top is

--Imports encoder
component encoder is
    port(   hex_in: in std_logic_vector(3 downto 0);
            a: out std_logic;
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

--Declares signals for components
signal w0: std_logic_vector(3 downto 0); --w0 or wire 0 is analogous to a(3), a(2), a(1), and a(0) augmented as shown in Figure 1, respectively
signal w1: std_logic_vector(3 downto 0);
signal w2: std_logic_vector(3 downto 0);
signal w3: std_logic_vector(3 downto 0);
signal w4: std_logic_vector(3 downto 0);
signal w5: std_logic_vector(3 downto 0);
signal w6: std_logic_vector(3 downto 0);

begin

--Connects the switches to the LEDs
led <= sw;

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
gen_enc: for i in 0 to 3 generate
    encx: encoder port map(hex_in => sw((4 * i + 3) downto (4 * i)), a => w0(i), b => w1(i), c => w2(i), d => w3(i), e => w4(i), f => w5(i), g => w6(i));
end generate gen_enc;

--enc1 is analogous to gen_enc[3]
--enc1: encoder port map( --Potentially use for generator statement
--    hex_in => sw(15 downto 12),
--    a => w0(3),
--    b => w1(3),
--    c => w2(3),
--    d => w3(3),
--    e => w4(3),
--    f => w5(3),
--    g => w6(3));

--enc2: encoder port map(
--    hex_in => sw(11 downto 8),
--    a => w0(2),
--    b => w1(2),
--    c => w2(2),
--    d => w3(2),
--    e => w4(2),
--    f => w5(2),
--    g => w6(2));

--enc3: encoder port map(
--    hex_in => sw(7 downto 4),
--    a => w0(1),
--    b => w1(1),
--    c => w2(1),
--    d => w3(1),
--    e => w4(1),
--    f => w5(1),
--    g => w6(1));

--enc4: encoder port map(
--    hex_in => sw(3 downto 0),
--    a => w0(0),
--    b => w1(0),
--    c => w2(0),
--    d => w3(0),
--    e => w4(0),
--    f => w5(0),
--    g => w6(0));

end Behavioral;
