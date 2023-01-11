// The sum of all scores in a round did not add to the right value
class InvalidScoreSumException with Exception
{
  int currentSum;
  int targetSum;

  InvalidScoreSumException(this.currentSum, this.targetSum);
}

// There was a negative score when there should not have been one
class NegativeScoreException with Exception
{
  int offendingScoreIndex;

  NegativeScoreException(this.offendingScoreIndex);
}

// Some player has a score that is impossible to get in the current round
class InvalidIndividualScoreException with Exception
{
  int offendingScoreIndex;

  InvalidIndividualScoreException(this.offendingScoreIndex);
}

// In round 6, there might not be the correct number of negative scores
class NotEnoughNegativesScoreException with Exception
{
  int desiredNegatives;
  int currentNegatives;

  NotEnoughNegativesScoreException(this.desiredNegatives, this.currentNegatives);
}

// In round 6, there might not be the correct number of positive scores
class NotEnoughPositiveScoreException with Exception
{
  int desiredPositives;
  int currentPositives;

  NotEnoughPositiveScoreException(this.desiredPositives, this.currentPositives);
}