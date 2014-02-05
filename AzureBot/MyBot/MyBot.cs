using RockPaperScissorsPro;
using System;

namespace RockPaperAzure
{
    public class MyBot : IRockPaperScissorsBot
    {
        int x = 0, ties = 0, pattern = 0, patternintervals = 0, patternmovebased = 0, y = 0, movebasedpatternintervals = 0, tiebreaker = 2, countered = 0, failballoons = 0, sequence = 0;

      
        // zKarp implementation
        public Move MakeMove(IPlayer you, IPlayer opponent, GameRules rules)
        {
            x++;

            //First Move
            if (x == 1)
            {
                return Moves.GetRandomMove();
            }
            ///////

            //Use remaining Dynamites
            if ((you.DynamiteRemaining > 49) && (x >= 1000))
            {
                tiebreaker = 2;
            }

            if ((you.DynamiteRemaining > 10) && (x >= 1300))
            {
                sequence++;
                if (x % sequence == 0)
                {

                    you.Log.AppendLine("Sequenced Dynamite");
                    return Moves.Dynamite;
                }
            }
            /////////////

            //Pattern Fixer
            if ((you.LastMove == Moves.WaterBalloon) && (opponent.LastMove != Moves.Dynamite))
            {
                failballoons++;
            }

            if (failballoons == 1)
            {
                pattern = 0;
                patternintervals = 0;
                patternmovebased = 0;
                movebasedpatternintervals = 0;
                failballoons = 0;
            }
            ////////////


            //Tiebreaker changer
            if ((you.LastMove == Moves.Dynamite) && (opponent.LastMove == Moves.WaterBalloon) && (ties == tiebreaker))
            {
                countered++;
                if (countered==1)
                {
                    tiebreaker = tiebreaker - 1;

                    you.Log.AppendLine("Tie Breaker Changed");
                    countered=0;
                }

                if(tiebreaker<1)
                {
                    tiebreaker = 3;
                    countered = 0;
                }
            }
            ////////////


            //Dynomite Pattern Finder
            if (opponent.LastMove == Moves.Dynamite)
            {
                if(ties>0)
                {
                    pattern = ties;
                }

                if (ties == pattern)
                {
                    patternintervals++;
                }

                patternmovebased = x/(100-opponent.DynamiteRemaining);

                if (patternmovebased!=y)
                {
                    y=patternmovebased;
                    movebasedpatternintervals=0;
                }

                if (patternmovebased==y)
                {
                    movebasedpatternintervals++;
                }

            }
            /////////////

            
            ////Dynomite Killer Move Based
            if((movebasedpatternintervals>3) && (opponent.HasDynamite) && (x % patternmovebased==0))
            {
                return Moves.WaterBalloon;
            }
            ////



            //Tiess
            if (opponent.LastMove == you.LastMove)
            {
                ties++;
                if ((opponent.TeamName==("marsh")) && (ties==4))
                {
                    return Moves.WaterBalloon;
                }
                if ((ties == pattern) && (patternintervals>2) && (opponent.HasDynamite))
                {
                    return Moves.WaterBalloon;

                }
                if ((ties==tiebreaker) && (you.HasDynamite))
                {
                    return Moves.Dynamite;
                }

            }
            else
            {
                ties = 0;
            }
            /////////

          
            return Moves.GetRandomMove();
            
        }

    }

}