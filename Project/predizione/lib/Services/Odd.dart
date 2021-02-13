
class Odd {
  Odd(
      this.hw,
      this.draw,
      );
  double home;
  double draw;
  double away;
  double hw;
  double aw;
  void PrintOdds(Odd odd){print("Home Win:"+odd.home.toString()+" Draw:"+odd.draw.toString()+" Away Win:"+odd.away.toString());}
  Odd fill(Odd o, List<Odd> betOdds){
    double dOdds=0;
    int occ=0;
    for(int i=0;i<betOdds.length;i++){
      if(o.hw-0.5<betOdds[i].hw && o.hw-0.05<betOdds[i].hw){
    occ+=1;
    dOdds+=betOdds[i].draw;
    }

    }
    o.draw=dOdds/occ;
    double total=1-o.draw;
    o.home=o.hw/total;
    o.away=o.aw/total;
    return o;
  }
}
