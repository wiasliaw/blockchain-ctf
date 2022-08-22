hello_ethernaut:; FOUNDRY_PROFILE=hello_ethernaut forge test -vvvv
fallback:; FOUNDRY_PROFILE=fallback forge test -vvvv
fallout:; FOUNDRY_PROFILE=fallout forge test -vvvv
king:; FOUNDRY_PROFILE=king forge test -vvvv

clean:; forge clean
.PHONY: test hello_ethernaut fallback fallout king