--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   10:26:41 04/30/2020
-- Design Name:   
-- Module Name:   D:/xdocka13/Projekt/keypad/decoder_keys_tb.vhd
-- Project Name:  keypad
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: decoder_keys
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
 
ENTITY decoder_keys_tb IS
END decoder_keys_tb;
 
ARCHITECTURE behavior OF decoder_keys_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT decoder_keys
    PORT(
         clk_i : IN  std_logic;
         rst_i : IN  std_logic;
         keys_in : IN  std_logic_vector(3 downto 0);
         unlock_in : IN  std_logic;
         ledgreen_out : OUT  std_logic;
         ledred_out : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk_i : std_logic := '0';
   signal rst_i : std_logic := '0';
   signal keys_in : std_logic_vector(3 downto 0) := (others => '0');
   signal unlock_in : std_logic := '0';

 	--Outputs
   signal ledgreen_out : std_logic;
   signal ledred_out : std_logic;

   -- Clock period definitions
   constant clk_i_period : time := 500 ms;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: decoder_keys PORT MAP (
          clk_i => clk_i,
          rst_i => rst_i,
          keys_in => keys_in,
          unlock_in => unlock_in,
          ledgreen_out => ledgreen_out,
          ledred_out => ledred_out
        );

   -- Clock process definitions
   clk_i_process :process
   begin
		clk_i <= '1';
		wait for clk_i_period/2;
		clk_i <= '0';
		wait for clk_i_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin	
		unlock_in<='1';
		keys_in<="1100";
		
      rst_i<= '1';
      wait for 500ms;	
		rst_i<= '0';
      
		keys_in<="1100";
		wait for 1500 ms;
		keys_in<="0001";
		wait for 500 ms;
		keys_in<="0010";
		wait for 500 ms;
		
      keys_in<="1111";
		wait for 500 ms;
		unlock_in<='0';
		keys_in<="0100";
		wait for 500 ms;
      keys_in<="0011";
		wait for 500 ms;
		keys_in<="0100";
		wait for 500 ms;
		keys_in<="0001";
		wait for 500 ms;
		
		keys_in<="1110";
		wait for 500 ms;
		unlock_in<='1';
		
		keys_in<="1100";
		wait for 500 ms;
		keys_in<="1100";
		wait for 500 ms;
		
		
      keys_in<="0100";
		wait for 500 ms;
      keys_in<="0011";
		wait for 500 ms;
		keys_in<="0100";
		wait for 500 ms;
		keys_in<="0001";
		wait for 500 ms;
		keys_in<="0010";
		wait for 500 ms;
		keys_in<="0111";
		wait for 500 ms;
      keys_in<="1011";
		wait for 500 ms;
		keys_in<="1101";
		wait for 500 ms;
		keys_in<="1110";
      wait;
   end process;

END;
