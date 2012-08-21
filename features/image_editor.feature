Feature: Image Editor
  As a user of the image editor
  I want to manipulate pixels
  So I can change the appearance of the image


  Scenario: Creating a new image
    When I create a new image with 5 rows & 6 cols
    Then I should see the following image:
      | O    | O    | O    | O    | O    | O    |
      | O    | O    | O    | O    | O    | O    |
      | O    | O    | O    | O    | O    | O    |
      | O    | O    | O    | O    | O    | O    |
      | O    | O    | O    | O    | O    | O    |

  Scenario: Colouring a pixel
    Given I created an image
    When I colour the pixel 2,4 with colour "C"
    Then I should see the following image:
      | O    | O    | O    | O    | O    |
      | O    | O    | O    | O    | O    |
      | O    | O    | O    | O    | O    |
      | O    | C    | O    | O    | O    |
      | O    | O    | O    | O    | O    |

  Scenario: Colouring a vertical range
    Given I created an image
    When I colour a vertical range in column 3, from 2 until 4 with colour "W"
    Then I should see the following image:
      | O    | O    | O    | O    | O    |
      | O    | O    | W    | O    | O    |
      | O    | O    | W    | O    | O    |
      | O    | O    | W    | O    | O    |
      | O    | O    | O    | O    | O    |

  Scenario: Colouring a horizontal range
    Given I created an image
    When I colour a horizontal range in row 2, from 3 until 4 with colour "Z"
    Then I should see the following image:
      | O    | O    | O    | O    | O    |
      | O    | O    | Z    | Z    | O    |
      | O    | O    | O    | O    | O    |
      | O    | O    | O    | O    | O    |
      | O    | O    | O    | O    | O    |

  Scenario: Colouring a mixed range
    Given I created an image
    When I colour a vertical range in column 4, from 1 until 5 with colour "R"
    And I colour a horizontal range in row 2, from 4 until 5 with colour "B"
    Then I should see the following image:
      | O    | O    | O    | R    | O    |
      | O    | O    | O    | B    | B    |
      | O    | O    | O    | R    | O    |
      | O    | O    | O    | R    | O    |
      | O    | O    | O    | R    | O    |

  Scenario: Clearing the image
    Given I created a coloured image
    Then I should see the following image:
      | B    | B    | B    | B    | B    |
      | B    | B    | B    | B    | B    |
      | B    | B    | B    | B    | B    |
      | B    | B    | B    | B    | B    |
      | B    | B    | B    | B    | B    |
    When I clear the image
    Then I should see the following image:
      | O    | O    | O    | O    | O    |
      | O    | O    | O    | O    | O    |
      | O    | O    | O    | O    | O    |
      | O    | O    | O    | O    | O    |
      | O    | O    | O    | O    | O    |
