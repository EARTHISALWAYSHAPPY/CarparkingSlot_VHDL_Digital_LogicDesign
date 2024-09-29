library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Parking_Counter is
    Port ( clk : in STD_LOGIC;
        reset : in STD_LOGIC;
        car_in : in STD_LOGIC;
        car_out : in STD_LOGIC;
        count : out INTEGER range 0 to 15;
        empty_count : out INTEGER range 0 to 15; -- 
        empty : out STD_LOGIC; --
        full : out STD_LOGIC);
end Parking_Counter;

architecture rtl of Parking_Counter is
    signal counter : INTEGER range 0 to 15 := 0;
begin

    process(clk, reset)
    begin
        if reset = '1' then
            counter <= 0;
        elsif rising_edge(clk) then
            if car_in = '1' and counter < 15 then
                counter <= counter + 1;
            elsif car_out = '1' and counter > 0 then
                counter <= counter - 1;
            end if;
        end if;
    end process;

    count <= counter;
    
    empty_count <= 15 - counter; --
    
    full <= '1' when counter = 15 else '0';

    empty <= '1' when counter >= 0 and counter <= 14 else '0'; --
    
end architecture rtl;
