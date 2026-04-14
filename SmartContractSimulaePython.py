Candidate = {}
Jury = {}

def addCandidate(name):
    Candidate[name] = 0
    
def addJury(adress,vote):
    Jury[adress] = {}
    Jury[adress]["vote"] = vote
    Jury[adress]["isjury"] = True
    
addCandidate("ghaith")

addJury(111,10)
addJury(222,10)
addJury(333,10)

def addVote(idCandidate,idJury):
    if(idCandidate in Candidate and idJury in Jury):
        
        if(Jury[idJury]["isjury"] and Jury[idJury]["vote"]>0):
            Candidate[idCandidate]+=1
            Jury[idJury]["vote"]-=1
            print("vote succes")
        else:
            print("you left your vote")

addVote("ghaith",111)
addVote("ghaith",111)
addVote("ghaith",111)
addVote("ghaith",111)
addVote("ghaith",111)
addVote("ghaith",111)
addVote("ghaith",111)
addVote("ghaith",111)
addVote("ghaith",111)
addVote("ghaith",111)
  
 
 
