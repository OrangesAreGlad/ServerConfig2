register_command('fusrodah', 
    array(
        'description': 'Power',
        'permission': 'ch.alias.fusrodah',
        'noPermMsg': 'Sorry you don\'t have permission to use this command.',
        'executor': closure() {
        
            @player = player()
            assign(@cooldown, 10)

            assign(@lastUsedThuum, import(@player."lastUsedThuum"))
            
            if(@lastUsedThuum + @cooldown > time() / 1000,
                die(color('GRAY')."Your Thu'um is too weak, you must wait for it to strengthen.")
            )
            export(@player."lastUsedThuum", time() / 1000)

            @ploc = ploc()
            @allPlayers = players_in_radius(@ploc,30)

            foreach(@player in @allPlayers) {
                
                if(@player != player()){

                    @vicLoc = ploc(@player)

                    @x1 = @ploc['x']
                    @y1 = @ploc['y']
                    @z1 = @ploc['z']

                    @x2 = @vicLoc['x']
                    @y2 = @vicLoc['y']
                    @z2 = @vicLoc['z']

                    @x3 = pow(@x1 - @x2, 2)
                    @y3 = pow(@y1 - @y2, 2)
                    @z3 = pow(@z1 - @z2, 2)

                    @final = @x3 + @y3 + @z3

                    @final = sqrt(@final)
                    
                    @maxDist = 30
                    @magnitude = (1 - @final / @maxDist) * 5 

                    @yaw = @ploc['yaw'] + 90;
                    @pitch = neg(@ploc['pitch']);
                    @vector = associative_array();
                    @vector['x'] = @magnitude * (cos(to_radians(@yaw)) * cos(to_radians(@pitch)));
                    @vector['y'] = @magnitude * sin(to_radians(@pitch));
                    @vector['z'] = @magnitude * (sin(to_radians(@yaw)) * cos(to_radians(@pitch)));
                    set_pvelocity(@player,@vector) 
                }
            }
                
        }
    )
)
