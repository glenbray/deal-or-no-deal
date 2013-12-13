package gameManager;

import java.io.Serializable;

public class BriefCase implements Serializable {
	
	boolean isOpen;
	double amount;
	
	public BriefCase() {
	}
	
	public BriefCase(double amount) {
		
		this.isOpen = false;
		this.amount = amount;
	}
		
	//Check if briefcase is open
	public boolean isOpen() { 
		return isOpen;
	}

	//Set briefcase open state
	public void setOpen(boolean isOpen) { 
		this.isOpen = isOpen;
	}

	//Get amount in briefcase
	public double getAmount() { 
		return amount;
	}

	
}
