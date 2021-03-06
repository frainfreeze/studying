﻿namespace DataLayer
{
    public class Player
    {
        public string name { get; set; }
        public string shirt_number { get; set; }
        public string position { get; set; }
        public bool captain { get; set; }
        public int goals { get; set; }
        public int cards { get; set; }
        public bool favorite { get; set; }

        public override string ToString() => $"{name} {shirt_number} {position} {(captain ? "yes" : "no")} {goals} {cards}";
    }
}
