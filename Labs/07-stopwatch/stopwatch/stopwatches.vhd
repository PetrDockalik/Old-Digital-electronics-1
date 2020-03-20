------------------------------------------------------------------------
--
-- Implementation of stopwatch.
-- Xilinx XC2C256-TQ144 CPLD, ISE Design Suite 14.7
--
-- Copyright (c) 2019-2020 Tomas Fryza
-- Dept. of Radio Electronics, Brno University of Technology, Czechia
-- This work is licensed under the terms of the MIT license.
--
------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

------------------------------------------------------------------------
-- Entity declaration for top level
------------------------------------------------------------------------
entity top is
port (
    clk_i      : in  std_logic;     -- 10 kHz clock signal
    BTN0       : in  std_logic;     -- Synchronous reset
	 BTN1       : in  std_logic;     -- Enable clock
	 disp_dp    : out std_logic;
    disp_seg_o : out std_logic_vector(7-1 downto 0);
    disp_dig_o : out std_logic_vector(4-1 downto 0)
);
end entity top;

------------------------------------------------------------------------
-- Architecture declaration for top level
------------------------------------------------------------------------
architecture Behavioral of top is
    signal s_en  : std_logic;
	 signal s_a  : std_logic_vector(4-1 downto 0);
	 signal s_b  : std_logic_vector(4-1 downto 0);
	 signal s_c  : std_logic_vector(4-1 downto 0);
	 signal s_d  : std_logic_vector(4-1 downto 0);
begin

    --------------------------------------------------------------------
    -- Sub-block of clock_enable entity
    CLK_EN_0 : entity work.clock_enable
    generic map (
        g_NPERIOD => x"0064"       
    )
    port map (
        clk_i          => clk_i,    
        srst_n_i       => BTN0,     
        clock_enable_o => s_en
    );


    --------------------------------------------------------------------
    -- Sub-block of binary_cnt entity
    BIN_CNT_0 : entity work.binary_cnt
	 generic map(
    g_NBIT => 2      -- Number of bits
)
port map(
    clk_i => clk_i,  
    srst_n_i => BTN0,
    ce_10kHz_i => s_en,
	 cnt_en_i => BTN1,   	 
    hth_l_i => s_a, 
	 hth_h_i => s_b,
	 sec_l_i => s_c,
	 sec_h_i => s_d
);

	 --------------------------------------------------------------------
    -- Sub-block of driver_7seg entity
    HEX_TO_SEG : entity work.driver_7seg
    port map (
		 clk_i => clk_i, 
		 srst_n_i => BTN0,
		 data0_i => s_a,
		 data1_i => s_b,
		 data2_i => s_c,
		 data3_i => s_d,
		 dp_i => "1111",
		 dp_o => disp_dp,
		 seg_o => disp_seg_o,
		 dig_o => disp_dig_o
    );
end architecture Behavioral;