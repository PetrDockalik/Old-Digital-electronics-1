----------------------------------------------------------------------------------
------------------------------------------------------------------------
--
-- Xilinx XC2C256-TQ144 CPLD, ISE Design Suite 14.7
--
-- Copyright (c) 2019-2020 Tomas Fryza
-- Dept. of Radio Electronics, Brno University of Technology, Czechia
-- This work is licensed under the terms of the MIT license.
--
------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

------------------------------------------------------------------------
-- Entity declaration for top level
------------------------------------------------------------------------
entity top is
port (
    clk_i : in std_logic;       -- 10 kHz clock signal
    BTN0  : in std_logic;       -- Synchronous reset
    LD0,LD1,LD2,LD3,LD4,LD5 : out std_logic
);
end entity top;

------------------------------------------------------------------------
-- Architecture declaration for top level
------------------------------------------------------------------------
architecture Behavioral of top is
    signal s_en : std_logic;
	 signal semafor1: std_logic_vector(3-1 downto 0);
	 signal semafor2 : std_logic_vector(3-1 downto 0);
begin
	 
    CLK : entity work.clock_enable
    generic map (
        g_NPERIOD => x"2710"       
    )
    port map (
        clk_i          => clk_i,    
        srst_n_i       => BTN0,     
        clock_enable_o => s_en
    );
	 
	TRAFFIC : entity work.traffic_controller
    port map (
		clock_i => s_en,         
		ryg1_o=> semafor1,
		ryg2_o => semafor2,
		srst_n_i => BTN0  
    );
	 
	 
	 LD0 <= semafor1(2); 
	  LD1 <= semafor1(1);
	  LD2 <= semafor1(0);
	  LD3 <= semafor2(2);
	  LD4 <= semafor2(1);
	  LD5 <= semafor2(0);
	 
end architecture Behavioral;