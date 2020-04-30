--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   21:12:58 04/27/2020
-- Design Name:   
-- Module Name:   D:/xdocka13/Projekt/keypad/keypad_tb.vhd
-- Project Name:  keypad
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: keypad
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
 
ENTITY keypad_tb IS
END keypad_tb;
 
ARCHITECTURE behavior OF keypad_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT keypad
    PORT(
         clk_i : IN  std_logic;
         rst_i : IN  std_logic;
			unlock_o: OUT std_logic;
         rows : IN  std_logic_vector(3 downto 0);
         columns : OUT  std_logic_vector(2 downto 0);
         keys_out : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk_i : std_logic := '0';
   signal rst_i : std_logic := '0';
   signal rows : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal columns : std_logic_vector(2 downto 0);
	signal unlock_o : std_logic:= '1';
   signal keys_out : std_logic_vector(3 downto 0);
   -- Clock period definitions
   constant clk_i_period : time := 500 ms;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: keypad PORT MAP (
          clk_i => clk_i,
          rst_i => rst_i,
          rows => rows,
			 unlock_o=> unlock_o,
          columns => columns,
          keys_out => keys_out
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
		rows<="1111";
		
      rst_i<= '1';
      wait for 500ms;	
		rst_i<= '0';
      
		rows<="0111";
		wait for 500 ms;
		rows<="1101";
		wait for 500 ms;
		rows<="1110";
		wait for 500 ms;
      rows<="1110";
		wait for 500 ms;
		rows<="1011";
		wait for 500 ms;
      rows<="1110";
		wait for 500 ms;
		rows<="0111";
		wait for 500 ms;
		rows<="1101";
		wait for 500 ms;
		rows<="0111";
		wait for 500 ms;
		rows<="1011";
		wait for 500 ms;
		rows<="1101";
		wait for 500 ms;
      rows<="1110";
		wait for 500 ms;
		rows<="0111";
		wait for 500 ms;
      rows<="1011";
		wait for 500 ms;
		rows<="1101";
		wait for 500 ms;
		rows<="1110";
		wait for 500 ms;
		rows<="0111";
		wait for 500 ms;
      rows<="1011";
		wait for 500 ms;
		rows<="1101";
		wait for 500 ms;
		rows<="1110";
		
      wait;
   end process;

END;
