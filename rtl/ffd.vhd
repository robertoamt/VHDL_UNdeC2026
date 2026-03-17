library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

--Declara la interfaz del bloque
entity ffd is
  port (
    d : in std_logic;
    clk : in std_logic;
    rst : in std_logic;
    q : out std_logic;
    nq : out std_logic
    );
end entity ffd;

--Describe la funcionalidad del bloque
architecture beh of ffd is
begin
    process(clk,rst)--Asincronico
    begin
        if rst = '1' then --mayor prioridad
            q <= '0';
            nq <= '0';
        elsif rising_edge(clk) then
            q <= d;
            nq <= not d;
        end if;
    end process;
end architecture;


