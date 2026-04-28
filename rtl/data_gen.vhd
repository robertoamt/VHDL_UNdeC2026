library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity data_gen is
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
end data_gen;

architecture Behavioral of data_gen is
constant DATA_LENGHT : integer := 4;
signal index : unsigned(1 downto 0);
type DATA_DISPLAY is array (0 to DATA_LENGHT-1) of std_logic_vector (DATA_WIDHT-1 downto 0);
constant data_disp : DATA_DISPLAY := (
    0 => "0101010101",
    1 => "1111100000",
    2 => "0000011111",
    3 => "0011001100"
);

begin
    process(clk_in)
    begin
        if rising_edge(clk_in) then
            if rst_in = '1' then
                valido_out <= '0';
                data_out <= (others => '0');
                index <= (others => '0');
            else
                if listo_in = '1' then --Otro modulo puede recibir
                    valido_out <= '1'; --Envio dato valido
                    index <= index+1;
                    data_out <= data_disp(to_integer(index));
                end if;
            end if;
        end if;
    end process;
end Behavioral;