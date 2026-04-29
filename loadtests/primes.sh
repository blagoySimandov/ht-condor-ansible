#!/bin/bash
# Find primes up to N using trial division
N=${1:-1000000}
echo "Finding primes up to $N..."
for ((i=2; i<=N; i++)); do
    is_prime=1
    for ((j=2; j*j<=i; j++)); do
        if ((i % j == 0)); then
            is_prime=0
            break
        fi
    done
    if ((is_prime)); then
        echo $i
    fi
done
echo "Done."
