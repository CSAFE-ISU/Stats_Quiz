
library(shiny)

# ============================================================
# CSAFE Forensic Statistics Quiz
# Full Shiny app with built-in styling
# ============================================================

questions <- list(
  list(
    type = "multiple",
    question = "What is the mean of the numbers 2, 4, and 6?",
    choices = c("A. 3", "B. 4", "C. 5", "D. 6"),
    correct = "B. 4",
    explanation = paste(
      "The mean is calculated by adding the values and dividing",
      "by the number of values: (2 + 4 + 6) / 3 = 4."
    )
  ),
  
  list(
    type = "true_false",
    question = paste(
      "If a DNA test has a 1-in-100 chance of a false positive,",
      "that means there is a 1% chance that a person with a",
      "positive result is innocent."
    ),
    choices = c("True", "False"),
    correct = "False",
    explanation = paste(
      "A false-positive rate is not the same as the probability",
      "that a person is innocent given a positive result.",
      "That probability also depends on how common the source",
      "is in the relevant population."
    )
  ),
  
  list(
    type = "matching",
    question = "Match each statistical term with its definition.",
    correct = c(
      mean = "Average",
      median = "Middle value",
      range = "Highest minus lowest"
    ),
    explanation = paste(
      "The mean is the average, the median is the middle value",
      "when observations are ordered, and the range is the",
      "difference between the highest and lowest values."
    )
  ),
  
  list(
    type = "multiple",
    question = "What does a negative correlation between two variables indicate?",
    choices = c(
      "A. As one variable increases, the other tends to increase",
      "B. As one variable increases, the other tends to decrease",
      "C. The variables are unrelated",
      "D. One variable causes the other to change"
    ),
    correct = "B. As one variable increases, the other tends to decrease",
    explanation = paste(
      "A negative correlation means that higher values of one",
      "variable tend to be associated with lower values of the",
      "other. Correlation alone does not establish causation."
    )
  ),
  
  list(
    type = "multiple",
    question = paste(
      "A prosecutor argues that because the chance of finding",
      "a DNA match if a person is innocent is very small, the",
      "chance that the person is innocent given a DNA match",
      "must also be very small. What statistical fallacy is this?"
    ),
    choices = c(
      "A. The ecological fallacy",
      "B. The prosecutor's fallacy",
      "C. The gambler's fallacy",
      "D. Selection bias"
    ),
    correct = "B. The prosecutor's fallacy",
    explanation = paste(
      "The prosecutor's fallacy confuses the probability of",
      "the evidence given innocence with the probability of",
      "innocence given the evidence. These are different",
      "conditional probabilities."
    )
  )
)

# ============================================================
# CSAFE Branding
# Colors based on the uploaded CSAFE brand guide
# ============================================================

custom_css <- "
@import url('https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&display=swap');

:root {
  --csafe-sky: #40B4E5;
  --csafe-blue: #1E7BC0;
  --csafe-green: #77BC1F;
  --csafe-purple: #9F1B96;
  --csafe-navy: #003A70;
  --csafe-gray: #8A8A8D;
  --csafe-light-gray: #DFDEDE;
  --csafe-bg: #F4F7FA;
  --csafe-text: #263746;
  --csafe-border: #DCE4EA;
}

body {
  background: var(--csafe-bg);
  color: var(--csafe-text);
  font-family: 'Montserrat', sans-serif;
}

.app-container {
  max-width: 950px;
  margin: 0 auto;
  padding: 25px 18px;
}

.app-header {
  display: flex;
  align-items: center;
  gap: 25px;
  padding: 22px 28px;
  margin-bottom: 25px;
  background: #FFFFFF;
  border-radius: 14px;
  border-top: 5px solid var(--csafe-sky);
  box-shadow: 0 4px 16px rgba(0, 58, 112, 0.08);
}

.header-logo {
  flex-shrink: 0;
}

.csafe-logo {
  display: block;
  width: 165px;
  max-height: 110px;
  object-fit: contain;
}

.header-text h1 {
  color: var(--csafe-navy);
  font-size: 27px;
  font-weight: 700;
  margin: 0 0 8px;
}

.header-text p {
  color: var(--csafe-gray);
  font-size: 14px;
  line-height: 1.6;
  margin: 0;
}

.quiz-card {
  background: #FFFFFF;
  border-radius: 14px;
  padding: 35px 40px;
  box-shadow: 0 4px 18px rgba(0, 58, 112, 0.07);
  min-height: 430px;
}

.intro-screen,
.results-screen {
  text-align: center;
  padding: 15px 10px 20px;
}

.intro-logo {
  display: block;
  max-width: 230px;
  max-height: 150px;
  object-fit: contain;
  margin: 0 auto 25px;
}

.intro-screen h2,
.results-screen h2 {
  color: var(--csafe-navy);
  font-size: 27px;
  font-weight: 700;
  margin: 12px 0 18px;
}

.intro-screen p,
.results-screen p {
  color: var(--csafe-gray);
  font-size: 14px;
  line-height: 1.8;
  max-width: 650px;
  margin: 12px auto;
}

.intro-details {
  display: flex;
  justify-content: center;
  flex-wrap: wrap;
  gap: 10px;
  margin: 25px 0;
}

.intro-details span {
  display: inline-flex;
  align-items: center;
  gap: 8px;
  background: #EAF5FB;
  color: var(--csafe-navy);
  border: 1px solid #D2EAF6;
  border-radius: 25px;
  padding: 10px 15px;
  font-size: 12px;
  font-weight: 600;
}

.btn-primary-custom {
  background: var(--csafe-blue);
  color: #FFFFFF;
  border: none;
  border-radius: 7px;
  padding: 12px 25px;
  font-family: 'Montserrat', sans-serif;
  font-size: 14px;
  font-weight: 700;
  transition: background 0.2s ease, transform 0.2s ease;
}

.btn-primary-custom:hover,
.btn-primary-custom:focus {
  background: var(--csafe-navy);
  color: #FFFFFF;
  transform: translateY(-1px);
}

.btn-reset {
  background: #FFFFFF;
  color: var(--csafe-navy);
  border: 1px solid var(--csafe-border);
  border-radius: 7px;
  padding: 11px 20px;
  font-family: 'Montserrat', sans-serif;
  font-size: 13px;
  font-weight: 600;
}

.btn-reset:hover {
  background: #F1F5F8;
  color: var(--csafe-navy);
}

.progress-section {
  margin-bottom: 30px;
}

.progress-labels {
  display: flex;
  justify-content: space-between;
  color: var(--csafe-gray);
  font-size: 12px;
  font-weight: 600;
  margin-bottom: 10px;
}

.progress-track {
  width: 100%;
  height: 8px;
  background: #E8EDF1;
  border-radius: 10px;
  overflow: hidden;
}

.progress-fill {
  height: 100%;
  background: linear-gradient(
    90deg,
    var(--csafe-sky),
    var(--csafe-blue)
  );
  border-radius: 10px;
  transition: width 0.3s ease;
}

.question-title {
  color: var(--csafe-navy);
  font-size: 21px;
  font-weight: 700;
  line-height: 1.6;
  margin: 0 0 25px;
}

.shiny-options-group {
  display: flex;
  flex-direction: column;
  gap: 11px;
}

.shiny-options-group label {
  display: block;
  background: #FAFCFD;
  border: 1px solid var(--csafe-border);
  border-radius: 8px;
  padding: 14px 16px;
  margin: 0;
  cursor: pointer;
  line-height: 1.6;
  font-size: 13px;
  transition: background 0.2s ease, border 0.2s ease;
}

.shiny-options-group label:hover {
  background: #EFF8FC;
  border-color: var(--csafe-sky);
}

.shiny-options-group input {
  margin-right: 10px;
  accent-color: var(--csafe-blue);
}

.matching-container {
  display: flex;
  flex-direction: column;
  gap: 15px;
  margin: 20px 0;
}

.matching-row {
  display: grid;
  grid-template-columns: 120px 1fr;
  align-items: center;
  gap: 15px;
}

.matching-term {
  color: var(--csafe-navy);
  font-weight: 700;
  font-size: 14px;
}

.matching-row .form-group {
  margin-bottom: 0;
}

.matching-row select {
  min-height: 42px;
  border: 1px solid var(--csafe-border);
  border-radius: 7px;
  box-shadow: none;
  font-family: 'Montserrat', sans-serif;
  font-size: 13px;
}

.feedback-box {
  margin-top: 25px;
  padding: 20px;
  border-radius: 9px;
  line-height: 1.7;
  font-size: 13px;
}

.feedback-box h4 {
  font-weight: 700;
  margin: 0 0 10px;
  font-size: 16px;
}

.feedback-box p {
  margin: 0 0 8px;
}

.feedback-correct {
  background: #F0F8E9;
  border: 1px solid #C5E2AC;
  color: #365D1A;
}

.feedback-incorrect {
  background: #FFF4F1;
  border: 1px solid #EBC8BF;
  color: #843F31;
}

.correct-answer {
  margin-top: 12px;
  font-size: 13px;
}

.quiz-actions {
  display: flex;
  justify-content: space-between;
  align-items: center;
  gap: 12px;
  margin-top: 28px;
}

.score-display {
  display: inline-block;
  background: #EAF5FB;
  border: 1px solid #D2EAF6;
  border-radius: 12px;
  padding: 25px 45px;
  margin: 20px 0;
}

.score-number {
  color: var(--csafe-navy);
  font-size: 42px;
  font-weight: 700;
}

.score-label {
  color: var(--csafe-blue);
  font-size: 13px;
  font-weight: 700;
  margin-top: 6px;
}

.results-icon {
  color: var(--csafe-green);
  font-size: 45px;
  margin-bottom: 15px;
}

.results-message {
  margin-bottom: 25px !important;
}

.app-footer {
  text-align: center;
  color: var(--csafe-gray);
  font-size: 11px;
  padding: 20px 10px;
}

@media (max-width: 650px) {
  .app-container {
    padding: 12px 10px;
  }

  .app-header {
    flex-direction: column;
    text-align: center;
    gap: 12px;
    padding: 20px 15px;
  }

  .csafe-logo {
    width: 145px;
  }

  .header-text h1 {
    font-size: 22px;
  }

  .quiz-card {
    padding: 25px 18px;
  }

  .question-title {
    font-size: 18px;
  }

  .matching-row {
    grid-template-columns: 1fr;
    gap: 6px;
  }

  .quiz-actions {
    flex-direction: column;
    align-items: stretch;
  }

  .quiz-actions button {
    width: 100%;
  }
}
"

# ============================================================
# User Interface
# ============================================================

ui <- fluidPage(
  tags$head(
    tags$style(HTML(custom_css))
  ),
  
  div(
    class = "app-container",
    
    # Header
    div(
      class = "app-header",
      
      div(
        class = "header-logo",
        img(
          src = "csafe_logo.png",
          alt = "CSAFE logo",
          class = "csafe-logo"
        )
      ),
      
      div(
        class = "header-text",
        h1(
          icon("chart-bar"),
          " Forensic Statistics Quiz"
        ),
        p(
          "A quick knowledge check on statistical concepts ",
          "used in forensic science."
        )
      )
    ),
    
    # Quiz content
    div(
      class = "quiz-card",
      uiOutput("main_content")
    ),
    
    # Footer
    div(
      class = "app-footer",
      icon("university"),
      " Center for Statistics and Applications in Forensic Evidence (CSAFE)"
    )
  )
)

# ============================================================
# Server
# ============================================================

server <- function(input, output, session) {
  
  quiz_state <- reactiveValues(
    started = FALSE,
    finished = FALSE,
    question_index = 1,
    answers = vector("list", length(questions)),
    submitted = FALSE
  )
  
  current_question <- reactive({
    questions[[quiz_state$question_index]]
  })
  
  # ----------------------------------------------------------
  # Get the user's current answer
  # ----------------------------------------------------------
  
  get_user_answer <- function(question_index) {
    
    question <- questions[[question_index]]
    
    if (question$type == "matching") {
      return(
        c(
          mean = input$match_mean,
          median = input$match_median,
          range = input$match_range
        )
      )
    }
    
    input$answer
  }
  
  # ----------------------------------------------------------
  # Check answer
  # ----------------------------------------------------------
  
  check_answer <- function(question, answer) {
    
    if (question$type == "matching") {
      
      if (is.null(answer) || length(answer) != 3 ||
          any(is.na(answer)) || any(answer == "")) {
        return(FALSE)
      }
      
      return(
        identical(
          unname(answer),
          unname(question$correct)
        )
      )
    }
    
    identical(
      as.character(answer),
      as.character(question$correct)
    )
  }
  
  # ----------------------------------------------------------
  # Render app content
  # ----------------------------------------------------------
  
  output$main_content <- renderUI({
    
    # Welcome screen
    if (!quiz_state$started) {
      
      return(
        div(
          class = "intro-screen",
          
          img(
            src = "csafe_logo_notag.png",
            alt = "CSAFE logo",
            class = "intro-logo"
          ),
          
          h2(
            icon("graduation-cap"),
            " Welcome to the Quiz"
          ),
          
          p(
            "This short quiz covers basic statistical concepts ",
            "that can come up in forensic science."
          ),
          
          p(
            "Answer five questions and review the explanations ",
            "to reinforce your understanding."
          ),
          
          div(
            class = "intro-details",
            
            span(
              icon("list-ol"),
              " 5 Questions"
            ),
            
            span(
              icon("tasks"),
              " Multiple Choice, True/False, and Matching"
            ),
            
            span(
              icon("clock"),
              " Quick Quiz"
            )
          ),
          
          actionButton(
            "start_quiz",
            label = tagList(
              icon("play"),
              " Start Quiz"
            ),
            class = "btn-primary-custom"
          )
        )
      )
    }
    
    # Results screen
    if (quiz_state$finished) {
      
      score <- sum(
        vapply(
          quiz_state$answers,
          function(x) {
            !is.null(x) && isTRUE(x$correct)
          },
          logical(1)
        )
      )
      
      percentage <- round(
        score / length(questions) * 100
      )
      
      result_message <- if (percentage == 100) {
        "You answered every question correctly."
      } else if (percentage >= 60) {
        "Good work. Review the explanations to reinforce what you learned."
      } else {
        "Review the explanations and reset the quiz to try again."
      }
      
      return(
        div(
          class = "results-screen",
          
          div(
            class = "results-icon",
            icon("check-circle")
          ),
          
          h2("Quiz Complete!"),
          
          p("You have completed all five questions."),
          
          div(
            class = "score-display",
            
            div(
              class = "score-number",
              paste0(score, "/", length(questions))
            ),
            
            div(
              class = "score-label",
              paste0(percentage, "% Correct")
            )
          ),
          
          p(
            class = "results-message",
            result_message
          ),
          
          actionButton(
            "restart_quiz",
            label = tagList(
              icon("redo"),
              " Reset Quiz"
            ),
            class = "btn-primary-custom"
          )
        )
      )
    }
    
    # Current quiz question
    question <- current_question()
    question_number <- quiz_state$question_index
    total_questions <- length(questions)
    progress <- question_number / total_questions * 100
    
    div(
      class = "quiz-screen",
      
      # Progress
      div(
        class = "progress-section",
        
        div(
          class = "progress-labels",
          
          span(
            icon("book-open"),
            paste(
              "Question",
              question_number,
              "of",
              total_questions
            )
          ),
          
          span(
            paste0(round(progress), "%")
          )
        ),
        
        div(
          class = "progress-track",
          
          div(
            class = "progress-fill",
            style = paste0("width:", progress, "%")
          )
        )
      ),
      
      # Question content
      div(
        class = "question-section",
        
        h2(
          class = "question-title",
          question$question
        ),
        
        # Multiple choice or true/false
        if (question$type %in% c("multiple", "true_false")) {
          
          radioButtons(
            inputId = "answer",
            label = NULL,
            choices = question$choices,
            selected = character(0)
          )
          
        } else if (question$type == "matching") {
          
          # Matching question
          div(
            class = "matching-container",
            
            div(
              class = "matching-row",
              
              div(
                class = "matching-term",
                icon("calculator"),
                " Mean"
              ),
              
              selectInput(
                "match_mean",
                label = NULL,
                choices = c(
                  "Choose a definition" = "",
                  "Average",
                  "Middle value",
                  "Highest minus lowest"
                ),
                selected = ""
              )
            ),
            
            div(
              class = "matching-row",
              
              div(
                class = "matching-term",
                icon("sort-numeric-down"),
                " Median"
              ),
              
              selectInput(
                "match_median",
                label = NULL,
                choices = c(
                  "Choose a definition" = "",
                  "Average",
                  "Middle value",
                  "Highest minus lowest"
                ),
                selected = ""
              )
            ),
            
            div(
              class = "matching-row",
              
              div(
                class = "matching-term",
                icon("arrows-alt-h"),
                " Range"
              ),
              
              selectInput(
                "match_range",
                label = NULL,
                choices = c(
                  "Choose a definition" = "",
                  "Average",
                  "Middle value",
                  "Highest minus lowest"
                ),
                selected = ""
              )
            )
          )
        },
        
        # Feedback after submitting
        if (quiz_state$submitted) {
          
          answer_record <- quiz_state$answers[[question_number]]
          
          div(
            class = if (isTRUE(answer_record$correct)) {
              "feedback-box feedback-correct"
            } else {
              "feedback-box feedback-incorrect"
            },
            
            h4(
              if (isTRUE(answer_record$correct)) {
                tagList(
                  icon("check-circle"),
                  " Correct!"
                )
              } else {
                tagList(
                  icon("times-circle"),
                  " Not quite."
                )
              }
            ),
            
            p(question$explanation),
            
            if (!isTRUE(answer_record$correct)) {
              
              div(
                class = "correct-answer",
                
                strong(
                  icon("lightbulb"),
                  " Correct answer: "
                ),
                
                if (question$type == "matching") {
                  
                  paste(
                    "Mean = Average;",
                    "Median = Middle value;",
                    "Range = Highest minus lowest"
                  )
                  
                } else {
                  question$correct
                }
              )
            }
          )
        },
        
        # Buttons
        div(
          class = "quiz-actions",
          
          if (!quiz_state$submitted) {
            
            actionButton(
              "submit_answer",
              label = tagList(
                icon("check"),
                " Submit Answer"
              ),
              class = "btn-primary-custom"
            )
            
          } else {
            
            actionButton(
              "next_question",
              label = if (question_number == total_questions) {
                tagList(
                  icon("flag-checkered"),
                  " View Results"
                )
              } else {
                tagList(
                  "Next Question ",
                  icon("arrow-right")
                )
              },
              class = "btn-primary-custom"
            )
          }
        )
      )
    )
  })
  
  # ----------------------------------------------------------
  # Start quiz
  # ----------------------------------------------------------
  
  observeEvent(input$start_quiz, {
    
    quiz_state$started <- TRUE
    quiz_state$finished <- FALSE
    quiz_state$question_index <- 1
    quiz_state$answers <- vector("list", length(questions))
    quiz_state$submitted <- FALSE
    
  })
  
  # ----------------------------------------------------------
  # Submit answer
  # ----------------------------------------------------------
  
  observeEvent(input$submit_answer, {
    
    req(quiz_state$started)
    req(!quiz_state$finished)
    req(!quiz_state$submitted)
    
    question_index <- quiz_state$question_index
    question <- questions[[question_index]]
    user_answer <- get_user_answer(question_index)
    
    # Check that all matching fields are filled
    if (question$type == "matching") {
      
      if (
        is.null(user_answer) ||
        any(is.na(user_answer)) ||
        any(user_answer == "")
      ) {
        showNotification(
          "Please match all three terms before submitting.",
          type = "warning"
        )
        
        return()
      }
      
    } else {
      
      if (
        is.null(user_answer) ||
        length(user_answer) == 0 ||
        is.na(user_answer) ||
        user_answer == ""
      ) {
        showNotification(
          "Please select an answer before submitting.",
          type = "warning"
        )
        
        return()
      }
    }
    
    answer_is_correct <- check_answer(
      question,
      user_answer
    )
    
    quiz_state$answers[[question_index]] <- list(
      answer = user_answer,
      correct = answer_is_correct
    )
    
    quiz_state$submitted <- TRUE
    
  })
  
  # ----------------------------------------------------------
  # Next question or results
  # ----------------------------------------------------------
  
  observeEvent(input$next_question, {
    
    req(quiz_state$submitted)
    
    if (quiz_state$question_index < length(questions)) {
      
      quiz_state$question_index <- quiz_state$question_index + 1
      quiz_state$submitted <- FALSE
      
    } else {
      
      quiz_state$finished <- TRUE
    }
    
  })
  
  # ----------------------------------------------------------
  # Reset quiz
  # ----------------------------------------------------------
  
  observeEvent(input$restart_quiz, {
    
    quiz_state$started <- FALSE
    quiz_state$finished <- FALSE
    quiz_state$question_index <- 1
    quiz_state$answers <- vector("list", length(questions))
    quiz_state$submitted <- FALSE
    
  })
  
}

# ============================================================
# Run the app
# ============================================================

shinyApp(
  ui = ui,
  server = server
)
