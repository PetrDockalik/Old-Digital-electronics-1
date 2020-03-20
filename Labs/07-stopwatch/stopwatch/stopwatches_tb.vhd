--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   21:30:21 03/19/2020
-- Design Name:   
-- Module Name:   D:/xdocka13/Digital-electronics-1/Labs/07-stopwatch/stopwatch/stopwatches_tb.vhd
-- Project Name:  stopwatch
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: top
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY stopwatches_tb IS
END stopwatches_tb;
 
ARCHITECTURE behavior OF stopwatches_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT top
    PORT(
			clk_i : IN  std_logic;
         BTN0 : IN  std_logic;
			BTN1 : IN  std_logic;
         disp_dp : OUT  std_logic;
         disp_seg_o : OUT  std_logic_vector(6 downto 0);
         disp_dig_o : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
	signal BTN1 : std_logic := '0';
   signal clk_i : std_logic := '0';
   signal BTN0 : std_logic := '0';

 	--Outputs
   signal disp_dp : std_logic;
   signal disp_seg_o : std_logic_vector(6 downto 0);
   signal disp_dig_o : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant clk_i_period : time := 100 us;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: top PORT MAP (
			 clk_i => clk_i,
			 BTN1 => BTN1,
          BTN0 => BTN0,
          disp_dp => disp_dp,
          disp_seg_o => disp_seg_o,
          disp_dig_o => disp_dig_o
        );

--    Clock process definitions
   clk_i_process :process
   begin
		clk_i <= '0';
		wait for clk_i_period/2;
		clk_i <= '1';
		wait for clk_i_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin
	 BTN0 <= '1';
	 BTN1 <= '1';
	 wait for 200 ms;
	 
	 
    BTN1 <= '0';
	 wait for 120 ms;
	 BTN1 <= '1';
	 
	 
    BTN0 <= '0';
    wait for clk_i_period*100*2;
	 BTN0 <= '1';
      
  wait for 2000 ms;
   end process;

END;

