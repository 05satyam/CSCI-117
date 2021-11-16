import numpy as np
import matplotlib.pyplot as plt

def bandit(inputs):
    total_reward = 0
    mean_rewards = np.zeros(inputs["horizon"])
    regret = np.zeros(inputs["horizon"])
    action_select_counter = np.zeros(k)
    q_estimates = inputs["initialization"](inputs["k"], inputs["q_star"])

    for t in range(1,inputs["horizon"]+1): # loop over the horizon
        action = inputs["action_selection"](q_estimates, inputs, t, action_select_counter)
        action_select_counter[action] += 1
        reward = run_bandit(action, q_star)
        total_reward += reward
        mean_rewards[t-1] = total_reward/t
        regret[t-1] = np.max(q_star) - reward # We use the true maximum to calculate the regret :)
        q_estimates = inputs["update_rule"](q_estimates, action, reward, inputs, action_select_counter, mean_rewards[t-1])
    return q_estimates, total_reward, mean_rewards, regret

def run_bandit(action, q_star):
    return rng2.normal(q_star[action], 1)

def ZeroInitialization(k, q_star):
    return np.zeros(k)

def random_action_selection(estimates, bandit_inputs, t, action_select_counter):
    return rng2.randint(inputs["k"])

def update_rule(estimates, action, reward, inputs, action_select_counter, mean_reward):
    estimates[action] = estimates[action] + (reward - estimates[action]) / action_select_counter[action]
    return estimates

# Number of actions
k = 10
# Number of iterations
horizon = 5000
#Number of trials
trials=100

# Initialization of the true action values (q*) according to a gaussian distribution

q_star = [-0.70318731, -0.49028236, -0.32181433, -1.75507872,  0.20666447, -2.01126457, -0.55725071,  0.33721701,  1.54883597, -1.37073656]





def procedure(inputs, N):
    estimates = np.zeros(k)
    total_reward = 0
    mean_rewards = np.zeros(N)
    regret = np.zeros(N)
    for i in range(trials):
        i_estimates, i_total_reward, i_mean_rewards, i_regret = bandit(inputs)
        estimates += i_estimates
        total_reward += i_total_reward
        mean_rewards += i_mean_rewards
        regret += i_regret

    return estimates/trials, total_reward/trials, mean_rewards/trials, regret/trials


def plot_bandits(N, estimates, total_reward, mean_rewards, regret, q_star):
    """ Plots using matplotlib the regret curve and the average reward curve"""
    print("True q values:{}".format(q_star))
    print("Learned Estimates: {}".format(estimates))
    print("")
    print("Euclidean distance from q_star vector: {}".format(np.linalg.norm(q_star-estimates)))
    print("Total Reward: {}".format(total_reward))
    print("Mean Reward: {}".format(mean_rewards[-1]))

    fig, ax = plt.subplots()
    ax.plot(np.linspace(0,N-1,N), np.cumsum(regret), 'b-')
    ax.set_xlabel("Time")
    ax.set_ylabel("Speed")
    ax.grid()
    ax.set(xlabel='Time Steps', ylabel='Total Regret',
           title='Regret Curve')

    plt.show()

    fig, ax = plt.subplots()
    ax.plot(np.linspace(0,N-1,N), mean_rewards, 'b-')
    ax.set_xlabel("Time")
    ax.set_ylabel("Speed")
    ax.grid()
    ax.set(xlabel='Time Steps', ylabel='Average Reward',
           title='Average Reward Curve')

    plt.show()


#Seed our random engines:
rng2 = np.random.RandomState(1337)
rng3 = np.random.RandomState(1337)

#Initialize the experiment:
inputs = {"k"                 : k, # Number of actions
          "horizon"           : horizon, # Number of iterations
          "q_star"            : q_star, # The true unknown rewards
          "initialization"    : ZeroInitialization, # Initialization strategy
          "action_selection"  : random_action_selection, # Action selection strategy
          "update_rule"       : update_rule # The update rule
         }

#Run the experiment and plot:
estimates_rand, total_reward_rand, mean_rewards_rand, regret_rand = procedure(inputs,horizon)
plot_bandits(horizon, estimates_rand, total_reward_rand, mean_rewards_rand, regret_rand, q_star)


'''
output:
True q values:[-0.70318731, -0.49028236, -0.32181433, -1.75507872, 0.20666447, -2.01126457, -0.55725071, 0.33721701, 1.54883597, -1.37073656]
Learned Estimates: [-0.70063846 -0.49270771 -0.3200305  -1.76013991  0.20623764 -2.00577644
 -0.55665471  0.33438762  1.55087664 -1.36834396]

Euclidean distance from q_star vector: 0.009472480378776167
Total Reward: -2566.771691278456
Mean Reward: -0.513354338255691
'''



general bandit input1:
inputs = {"k"         : k, # Number of actions
  "horizon"           : horizon, # Number of iterations
  "q_star"            : q_star, # The true unknown rewards
  "initialization"    : MinInitialization, # Initialization strategy
  "action_selection"  : greedy_action_selection, # Action selection strategy
  "update_rule"       : update_rule, # The update rule
  "a"                 : 1,
 }



gradient bandit imput 2:

inputs = {"k"                 : k, # Number of actions
          "horizon"           : horizon, # Number of iterations
          "q_star"            : q_star, # The true unknown rewards
          "initialization"    : MinInitialization, # Initialization strategy
          "action_selection"  : softmax_action_selection, # Action selection strategy
          "update_rule"       : update_rule, # The update rule
          "tau"               : 0.3 # The tau parameter
         }

Above are the two startegies which I have used one is greedy action selection and another is softmax_action_selection
In both the approaches, k is 10, horizon is 5000 and update rule return the estimates using true avgerage update rule.
In short run greedy algorithm might gives us a better result for any action which might looks like its the only best apporach but after plotting and performing the experiment
I found out softmax_action_selection is much better in long run and give more promissing rewards result in long run.
