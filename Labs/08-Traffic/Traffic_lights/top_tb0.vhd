--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:48:56 03/28/2020
-- Design Name:   
-- Module Name:   D:/xdocka13/Digital-electronics-1/Labs/08-Traffic/Traffic_lights/top_tb0.vhd
-- Project Name:  Traffic_lights
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
 
ENTITY top_tb0 IS
END top_tb0;
 
ARCHITECTURE behavior OF top_tb0 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT top
    PORT(
         clk_i : IN  std_logic;
         BTN0 : IN  std_logic;
         LD0 : OUT  std_logic;
         LD1 : OUT  std_logic;
         LD2 : OUT  std_logic;
         LD3 : OUT  std_logic;
         LD4 : OUT  std_logic;
         LD5 : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk_i : std_logic := '0';
   signal BTN0 : std_logic := '0';

 	--Outputs
   signal LD0 : std_logic;
   signal LD1 : std_logic;
   signal LD2 : std_logic;
   signal LD3 : std_logic;
   signal LD4 : std_logic;
   signal LD5 : std_logic;

   -- Clock period definitions
   constant clk_i_period : time := 0.1 ms;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: top PORT MAP (
          clk_i => clk_i,
          BTN0 => BTN0,
          LD0 => LD0,
          LD1 => LD1,
          LD2 => LD2,
          LD3 => LD3,
          LD4 => LD4,
          LD5 => LD5
        );

   -- Clock process definitions
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
     BTN0 <= '0';
	  wait for clk_i_period*100000;
	  BTN0 <= '1';
   wait for 100000000 ms;
   end process;

END;
