class InvalidScoreSumException with Exception
{
  int currentSum;
  int targetSum;

  InvalidScoreSumException(this.currentSum, this.targetSum);
}

class NegativeScoreException with Exception
{
  int offendingScoreIndex;

  NegativeScoreException(this.offendingScoreIndex);
}

class InvalidIndividualScoreException with Exception
{
  int offendingScoreIndex;

  InvalidIndividualScoreException(this.offendingScoreIndex);
}
