----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:18:43 04/30/2020 
-- Design Name: 
-- Module Name:    top - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
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
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top is
port (
	 ROW0_CPLD,ROW1_CPLD,ROW2_CPLD,ROW3_CPLD:in std_logic; -- Rows Inputs
	 COL0_CPLD,COL1_CPLD,COL2_CPLD: out std_logic; -- Columns Output
    clk_i      : in  std_logic;     -- 10 kHz clock signal
    BTN0       : in  std_logic;     -- Reset
    LD0,LD1    : out  std_logic
);
end top;

architecture Behavioral of top is
signal s_en: std_logic;
signal s_unlock: std_logic;
signal s_keys: std_logic_vector(3 downto 0);
signal s_rows: std_logic_vector(3 downto 0);
signal s_columns: std_logic_vector(2 downto 0);
begin
-- Connect Inputs and Outputs
	 s_rows(0) <= ROW3_CPLD; 
    s_rows(1) <= ROW2_CPLD;
    s_rows(2) <= ROW1_CPLD;
    s_rows(3) <= ROW0_CPLD;

	COL2_CPLD <=s_columns(0);
	COL1_CPLD<=s_columns(1);
	COL0_CPLD<=s_columns(2);

-- Sub-block of decoder scanned keys
    CLOCK : entity work.clock_enable
    generic map(
    g_NPERIOD => x"1388"
	)
	port map(
    clk_i => clk_i,
    rst_i =>BTN0,
    clock_o => s_en
);

-- Sub-block of decoder scanned keys
    SCAN_KEYPAD : entity work.keypad
    port map (
	clk_i =>s_en,
	rst_i =>BTN0,
	unlock_o =>s_unlock,
	rows =>s_rows,
	columns =>s_columns,
	keys_out => s_keys
    );

 -- Sub-block of decoder scanned keys
    EVALUATION_KEYS : entity work.decoder_keys
    port map (
    clk_i =>s_en,
	rst_i =>BTN0,
	keys_in =>s_keys,
	unlock_in =>s_unlock,
	ledgreen_out =>LD1,
	ledred_out =>LD0
    );
	 
	 
end Behavioral;

