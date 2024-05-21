library ieee;
use ieee.std_logic_1164.all;

entity GATE is
    port (
        clk, button, sensor: in std_logic;
        pwm: out std_logic;
		   flag: out std_logic
		  
    );
end GATE;

architecture main of GATE is
    constant clk_hz : real := 10.0e6; -- Lattice iCEstick clock
    constant pulse_hz : real := 50.0;
    constant min_pulse_us : real := 500.0; -- TowerPro SG90 values
    constant max_pulse_us : real := 2500.0; -- TowerPro SG90 values
    constant step_bits : positive := 8; -- 0 to 255
    constant step_count : positive := 2**step_bits;
    
    -- Adjust the position range to open halfway
    constant half_open_position : integer := step_count / 2;
    signal position : integer range 0 to step_count - 1;
    signal motor_ctrl : std_logic := '0';
    signal delay_counter : natural range 0 to 30_000_000; 

begin
    process (clk)
    begin
        if rising_edge(clk) then
				
            if motor_ctrl = '1' then
                if position < half_open_position then
                    position <= position + 1;
                else
					     position <= half_open_position;
                    if delay_counter > 0 then
                        delay_counter <= delay_counter - 1;
                    else
						      if sensor = '0' then 
									 delay_counter <= 30_000_000;
								else
									 motor_ctrl <= '0'; -- Close the gate
								end if;
                    end if;
                end if;

            else
                position <= 0;
                if button = '0' then
                    delay_counter <= 30_000_000; -- Start the delay counter when sensor input is '0'
                    motor_ctrl <= '1'; -- Open the gate
                end if;
            end if;
        end if;
		flag<= motor_ctrl;
    end process;

    SERVO : entity work.servo(rtl)
        generic map (
            clk_hz => clk_hz,
            pulse_hz => pulse_hz,
            min_pulse_us => min_pulse_us,
            max_pulse_us => max_pulse_us,
            step_count => step_count
        )
        port map (
            clk => clk,
            rst => '0',
            position => position,
            pwm => pwm
        );	

end main;         


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package Gate_package is 
    component Gate is 
				port (
        clk, button, sensor: in std_logic;
        pwm: out std_logic;
		  flag: out std_logic
    );
end component;	 
end Gate_package ;
