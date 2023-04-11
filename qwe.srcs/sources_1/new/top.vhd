----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.04.2023 18:04:52
-- Design Name: 
-- Module Name: top - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top is
  Port (clk_i : in STD_LOGIC;
       rst_i : in STD_LOGIC;
       start_stop_button_i : in STD_LOGIC;
       led7_an_o : out STD_LOGIC_VECTOR (3 downto 0);
       led7_seg_o : out STD_LOGIC_VECTOR (7 downto 0));
end top;

architecture Behavioral of top is

--signal rst_i : std_logic := '0';
signal counter : std_logic_vector(16 downto 0) := (others => '0');      
signal diode : std_logic_vector(2 downto 0) := (others => '0');
signal btn_i : STD_LOGIC := '0';

component display is
Port ( 
    clk_i : in STD_LOGIC;
    rst_i : in STD_LOGIC;
    btn_i : in STD_LOGIC;
    --counter : buffer STD_LOGIC_VECTOR(16 downto 0);
    diode : buffer STD_LOGIC_VECTOR(2 downto 0);
    led7_an_o : out STD_LOGIC_VECTOR (3 downto 0);
    led7_seg_o : out STD_LOGIC_VECTOR (7 downto 0)
);
end component;
begin

wtf: display port map(
    clk_i => clk_i,
    rst_i => rst_i,
    btn_i => start_stop_button_i,
    led7_an_o => led7_an_o,
    led7_seg_o => led7_seg_o,
    --counter => counter,
    diode => diode
);

end Behavioral;
