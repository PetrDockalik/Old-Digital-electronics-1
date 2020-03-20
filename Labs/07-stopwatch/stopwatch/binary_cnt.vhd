------------------------------------------------------------------------
--
-- N-bit binary counter.
-- Xilinx XC2C256-TQ144 CPLD, ISE Design Suite 14.7
--
-- Copyright (c) 2019-2020 Tomas Fryza
-- Dept. of Radio Electronics, Brno University of Technology, Czechia
-- This work is licensed under the terms of the MIT license.
--
------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;    -- Provides unsigned numerical computation
use ieee.numeric_std.all;

------------------------------------------------------------------------
-- Entity declaration for N-bit binary counter
------------------------------------------------------------------------
entity binary_cnt is
generic(
    g_NBIT : positive := 2      -- Number of bits
);
port(
    clk_i    : in  std_logic;
    srst_n_i : in  std_logic;   -- Synchronous reset (active low)
    ce_10kHz_i  : in  std_logic;   -- Enable clock
	 cnt_en_i    : in  std_logic; -- Enable counter
    hth_l_i : out std_logic_vector(4-1 downto 0);
	 hth_h_i : out std_logic_vector(4-1 downto 0);
	 sec_l_i : out std_logic_vector(4-1 downto 0);
	 sec_h_i : out std_logic_vector(4-1 downto 0)
);
end entity binary_cnt;

------------------------------------------------------------------------
-- Architecture declaration for N-bit binary counter
------------------------------------------------------------------------
architecture Behavioral of binary_cnt is
    signal cnt_hth_l : std_logic_vector(4-1 downto 0) := (others => '0');
	 signal cnt_hth_h : std_logic_vector(4-1 downto 0) := (others => '0');
	 signal cnt_sec_l : std_logic_vector(4-1 downto 0) := (others => '0');
	 signal cnt_sec_h : std_logic_vector(4-1 downto 0) := (others => '0');
begin

    --------------------------------------------------------------------
    -- p_binary_cnt:
    -- Sequential process with synchronous reset and clock enable,
    -- which implements an one-way binary counter.
    --------------------------------------------------------------------
    p_binary_cnt : process (clk_i)
    begin
        if rising_edge(clk_i) then  -- Rising clock edge
            if srst_n_i = '0' then  -- Synchronous reset (active low)
                cnt_hth_l <= (others => '0');   -- Clear all bits
					 cnt_hth_h <= (others => '0');
					 cnt_sec_l <= (others => '0');
					 cnt_sec_h <= (others => '0');
            elsif ce_10kHz_i = '1' and cnt_en_i = '1' then
                cnt_hth_l <= cnt_hth_l + 1; -- Normal operation
					 if  cnt_hth_l > "1001" then
							cnt_hth_l <= (others => '0');
							cnt_hth_h <= cnt_hth_h + 1;
							if  cnt_hth_h > "1001" then
								cnt_hth_h <= (others => '0');
								cnt_sec_l <= cnt_sec_l + 1;
								if  cnt_sec_l > "1001" then
									cnt_sec_l <= (others => '0');
									cnt_sec_h <= cnt_sec_h + 1;
									if  cnt_sec_h > "0101" then
										cnt_hth_l <= (others => '0');   -- Clear all bits
										cnt_hth_h <= (others => '0');
										cnt_sec_l <= (others => '0');
										cnt_sec_h <= (others => '0');
									end if;
								end if;
							end if;
					end if;
            end if;
        end if;
    end process p_binary_cnt;

		hth_l_i <= cnt_hth_l;
		hth_h_i <= cnt_hth_h;
		sec_l_i <= cnt_sec_l;
		sec_h_i <= cnt_sec_h;

end architecture Behavioral;