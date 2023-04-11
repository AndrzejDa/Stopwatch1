----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.03.2023 22:36:06
-- Design Name: 
-- Module Name: display - Behavioral
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
use IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
-- use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity display is
    Port ( 
            clk_i : in STD_LOGIC;
            rst_i : in STD_LOGIC;
            btn_i : in STD_LOGIC;
            --counter : buffer STD_LOGIC_VECTOR(16 downto 0);
            diode : buffer STD_LOGIC_VECTOR(2 downto 0);
            led7_an_o : out STD_LOGIC_VECTOR (3 downto 0);
            led7_seg_o : out STD_LOGIC_VECTOR (7 downto 0)
        );
end display;

architecture Behavioral of display is

signal start : boolean := false;
signal stop : boolean := false;
signal prev_ss : std_logic := '0';
signal counter : unsigned(27 downto 0) := (others => '0');
signal temp : std_logic_vector(6 downto 0) := "1111111";
signal state1 : std_logic_vector(6 downto 0) := "0000000";
signal state2 : std_logic_vector(6 downto 0) := "0000000";
signal state3 : std_logic_vector(6 downto 0) := "0000000";
signal state4 : std_logic_vector(6 downto 0) := "0000000";

begin

process(clk_i,rst_i,btn_i)
variable count_ms : integer range 0 to 500000000 := 0;
variable seconds : integer range 0 to 59 := 0;
variable mili_sec : integer range 0 to 99 := 0;

begin

    if(rst_i = '1') then
        start   <= false;
        stop <= false;
        counter <= (others => '0');
        led7_an_o <= "1110";
        led7_seg_o(7 downto 0) <= "00000011";
        led7_an_o <= "1101";
        led7_seg_o(7 downto 0) <= "00000011";
        led7_an_o <= "1011";
        led7_seg_o(7 downto 0) <= "00000010";
        led7_an_o <= "0111";
        led7_seg_o(7 downto 0) <= "00000011";

    elsif (btn_i = '1' and prev_ss = '0') then
        if (not start) then                             --start
            start   <= true;
            stop <= false;
        elsif (start and not stop) then                 --stop
            stop <= true;
        elsif (start and stop) then                     --reset
            start   <= false;
            stop <= false;
            counter <= (others => '0');
            led7_an_o <= "1110";
            led7_seg_o(7 downto 0) <= "00000011";
            led7_an_o <= "1101";
            led7_seg_o(7 downto 0) <= "00000011";
            led7_an_o <= "1011";
            led7_seg_o(7 downto 0) <= "00000010";
            led7_an_o <= "0111";
            led7_seg_o(7 downto 0) <= "00000011";
        end if;
    end if;
    prev_ss <= btn_i;
    
    if (start = true) and (stop = false) then
        if rising_edge(clk_i) then
            counter <= counter +1;
        end if;
        count_ms := to_integer(counter / 100000);
        mili_sec := count_ms;
        seconds := count_ms / 1000;
        state1 <= std_logic_vector(to_unsigned(mili_sec mod 10, 7));
        state2 <= std_logic_vector(to_unsigned((mili_sec / 100) mod 10, 7));
        state3 <= std_logic_vector(to_unsigned(seconds mod 10 , 7));
        state4 <= std_logic_vector(to_unsigned((seconds / 10) mod 10 , 7));
    end if;
    
    
    case state1 is
    when "0000000" => temp <= "0000001";
    when "0000001" => temp <= "1111001";
    when "0000010" => temp <= "0010010";
    when "0000011" => temp <= "0000110";
    when "0000100" => temp <= "1001100";
    when "0000101" => temp <= "0100100";
    when "0000110" => temp <= "0100000";
    when "0000111" => temp <= "0001111";
    when "0001000" => temp <= "0000000";
    when "0001001" => temp <= "0000100";
    when others => temp <= "1111111";
    end case;
        
    led7_seg_o(7 downto 1) <= temp;
    led7_an_o <= "1110";
    
    
    case state2 is
    when "0000000" => temp <= "0000001";
    when "0000001" => temp <= "1111001";
    when "0000010" => temp <= "0010010";
    when "0000011" => temp <= "0000110";
    when "0000100" => temp <= "1001100";
    when "0000101" => temp <= "0100100";
    when "0000110" => temp <= "0100000";
    when "0000111" => temp <= "0001111";
    when "0001000" => temp <= "0000000";
    when "0001001" => temp <= "0000100";
    when others => temp <= "1111111";
    end case;
    led7_seg_o(7 downto 1) <= temp;
    led7_an_o <= "1101";
    
    
    case state3 is
    when "0000000" => temp <= "0000001";
    when "0000001" => temp <= "1111001";
    when "0000010" => temp <= "0010010";
    when "0000011" => temp <= "0000110";
    when "0000100" => temp <= "1001100";
    when "0000101" => temp <= "0100100";
    when "0000110" => temp <= "0100000";
    when "0000111" => temp <= "0001111";
    when "0001000" => temp <= "0000000";
    when "0001001" => temp <= "0000100";
    when others => temp <= "1111111";
    end case;
    led7_seg_o(7 downto 1) <= temp;
    led7_an_o <= "1011";
    
    
    case state4 is
    when "0000000" => temp <= "0000001";
    when "0000001" => temp <= "1111001";
    when "0000010" => temp <= "0010010";
    when "0000011" => temp <= "0000110";
    when "0000100" => temp <= "1001100";
    when "0000101" => temp <= "0100100";
    when "0000110" => temp <= "0100000";
    when "0000111" => temp <= "0001111";
    when "0001000" => temp <= "0000000";
    when "0001001" => temp <= "0000100";
    when others => temp <= "1111111";
    end case;
    led7_seg_o(7 downto 1) <= temp;
    led7_an_o <= "0111";
    
    if (seconds >= 59) and (mili_sec >= 99) then
        led7_seg_o <= "11111101";
        led7_an_o <= "0000";
    end if;
    
    
    
    

end process;
    
end Behavioral;
