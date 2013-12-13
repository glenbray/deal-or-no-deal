package gameManager;

import java.io.Serializable;
import java.security.SecureRandom;
import java.text.DecimalFormat;
import java.util.List;
import java.util.ArrayList;

public class Player implements Serializable {
	
	private BriefCase[] briefCases;
	private int openedCount; 		// How many cases have been opened
	private int currentRound;		// Current Round
	private int selected; 			// Currently Selected Case
	private double win; 			// The amount the player received when they have the game ends
	private boolean endRound;
	private double largestAmount;	// Largest amount yet to be reveled
	private int remainingCasesCount;
	
	//instantiate briefcase array and fill with values
	public Player() { 
		
		double[] money = new double[]{0.5, 1, 10, 100, 200, 500, 1000, 2000, 5000, 10000, 20000, 50000};
		
		for(int i = 0; i <= money.length - 1; i++) //Randomize the values
		{
			SecureRandom random = new SecureRandom();
			int num = random.nextInt(money.length);
			
			double temp = money[i];
			money[i] = money[num];
			money[num] = temp;
		}
		
		briefCases = new BriefCase[money.length];
		
		for(int i = 0; i <= money.length - 1; i++) //Fill brief cases with randomized values;
			briefCases[i] = new BriefCase(money[i]);
		
		this.endRound = false;
		this.currentRound = 0; //Set current round to 1
	}

	//Check if at round end
	public boolean isEndRound() {
		return endRound;
	}

	//Set if round has ended
	public void setEndRound(boolean endRound) {
		this.endRound = endRound;
	}

	//Open briefcase at position
	public void openCase(int position) { 
		++openedCount;
		this.briefCases[position].setOpen(true);
		this.selected = position + 1;
		
		switch(openedCount) // set current round
		{
			case 1:
				this.currentRound = 1;
				break;
			case 4:
				this.currentRound = 2;
				this.endRound = true;
				break;
			case 7:
				this.currentRound = 3;
				this.endRound = true;
				break;
			case 9:
				this.currentRound = 4;
				this.endRound = true;
				break;
			case 10:
				this.currentRound = 5;
				this.endRound = true;
				break;
			case 11:
				this.currentRound = 6;
				this.endRound = true;
				break;
		}
	}
	
	//Get selected case
	public int getSelected() { 
		return selected;
	}
	
	//Get current Round
	public int getCurrentRound() { 
		return this.currentRound;
	}
	
	//Check if briefcase is open at position
	public boolean isOpened(int position) { 
		return this.briefCases[position].isOpen();
	}
	
	//Returns the amount in a case at a certain position
	public double getCase(int position) { 
		double amount = this.briefCases[position].getAmount();
		return amount;
	}	
		
	// Returns array of all unopened cases
	public Double[] getUnopened() { 
	
		List<Double> unopened = new ArrayList<Double>();
		
		for(int i = 0; i <= this.briefCases.length - 1; i++) //Count all unopened cases
		{
			if(!this.briefCases[i].isOpen())
				unopened.add(this.briefCases[i].getAmount());
		}		 
				
		return unopened.toArray(new Double[unopened.size()]);		
	}
	
	// Returns Bank Offer
	public double bankOffer() { 
		
		Double[] unopened = this.getUnopened();
		double sum = 0;
		
		for(int i = 0; i <= unopened.length - 1; i++)		
			sum += unopened[i];
		
		sum = sum / unopened.length;
		
		return this.round(sum);
	}
	
	//Get largest amount that is not opened
	public double getLargestAmount() { 
		
		this.largestAmount = 0;
		if(this.briefCases != null)
		{
			for(int i = 0; i <= this.briefCases.length - 1; i++)
			{
				if(this.briefCases[i].getAmount() > this.largestAmount && !this.briefCases[i].isOpen())
					this.largestAmount = this.briefCases[i].getAmount();
			}
		}
		return this.largestAmount;
	}
	
	//Returns a count on how many cases are yet to be opened
	public int getRemainingCasesCount()
	{
		this.remainingCasesCount = this.briefCases.length - this.openedCount;			
		return this.remainingCasesCount;
	}
	
	//Returns the amount won by the player
	public double getWin() { 
		
		if(this.currentRound == 6)
			this.win = this.getLargestAmount();
		else		
			this.win = this.bankOffer();
		
		return this.win;
	}
	
	// Returns the amount of cases opened
	public int getOpenedCount() { 
		return openedCount;
	}	
	
	//Returns double as 1 decimal place
	private double round(double r) {
		DecimalFormat round = new DecimalFormat( "#.#");
		return Double.valueOf(round.format(r));
		
	}
}
