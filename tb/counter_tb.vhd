library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity counter_tb is
end counter_tb;

architecture Behavioral of counter_tb is

component counter
  Port ( 
        clk_in : in std_logic;
        rst_in : in std_logic;
        data_out : out std_logic_vector(3 downto 0)  
  );
end component;

signal clk_in_tb : std_logic := '0';
signal rst_in_tb : std_logic;
signal data_out_tb : std_logic_vector(3 downto 0);

begin

c_1: counter
    port map(
            clk_in => clk_in_tb,
            rst_in => rst_in_tb,
            data_out => data_out_tb  
    );

clk_in_tb <= not clk_in_tb after 10 ns;
rst_in_tb <= '0', '1' after 30 ns, '0' after 200 ns; 
end Behavioral;
