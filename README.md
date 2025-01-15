# Bus_sync
## Description
> Classical way to deal with multiple bit CDC crossing involve one-bit load signal. Load signal from clock domain-a will first be sync to domain-b by double FF synchonizer.
> The domain-b signal sync_load will indicate when is the proper time to load multi-bit signal from domain-a to domain-b.
> If load signal is not available, some special technique will have to be adopted to avoid glitch states.
## Why not just 2FF synchonizer for multi-bit signals?
> For multi-bit signal clock domain crossing, not all bits can be sample in one specific clock edge. For example 4-bit binary counter transition from 0111->1000
> involve all 4 bit transition in one clock edge. Trying to sample this binary signal to another clock domain will be a disaster. Because of bit skew, random condions from 0000, 0001 ... 1111
> are all possible outcomes. Even though we can deal with metastable using 2FF synchonizer, glitch states will have to be dealt using other techniques. 
## Block diagram for multi-bit CDC handeling without load signal
![image](https://github.com/Sbing-yuan/Bus-sync/blob/main/Bus_sync.PNG)
- Bus_in : multi-bit signal from domain-a
- Bus_sync : multi-bit siganl crossed from domain-a to domain-b
- qualifier : indicate safe pass, stop glitch state crossing
## Timing
![image](https://github.com/Sbing-yuan/Bus-sync/blob/main/Bus_sync3.PNG)
- case1 : without glitch state
- case2 : glitch state emerge but not able to pass through
