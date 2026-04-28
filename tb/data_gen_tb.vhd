library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity data_gen_tb is --entidad vacia
end entity data_gen_tb;

architecture test_data_gen of data_gen_tb is

    component data_gen is
    generic(
            DATA_WIDHT : integer := 10
    );
    Port ( 
            clk_in : in std_logic;
            rst_in : in std_logic;
            data_out : out std_logic_vector(DATA_WIDHT-1 downto 0);
            valido_out : out std_logic;
            listo_in : in std_logic
    );
    end component;
    
    signal clk_tb, rst_tb, valido_tb, listo_tb : std_logic;
    signal data_tb : std_logic_vector(9 downto 0);

    begin
    
    mi_gen: data_gen
     port map( clk_in => clk_tb,
               rst_in => rst_tb,
               data_out => data_tb,
               valido_out => valido_tb,
               listo_in => listo_tb
               );
    process
    begin
        clk_tb <= '0';
        wait for 1 ms;
        clk_tb <= '1';
        wait for 1 ms;
    end process;

    rst_tb <= '1', '0' after 10 ms;
    listo_tb <= '0', '1' after 8 ms, '0' after 50 ms;


end architecture;