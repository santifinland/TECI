import pandas as pd
from sklearn import linear_model


def regresion(x, y):
    # Create linear regression object
    regr = linear_model.LinearRegression()
    regr.fit(x, y)
    return regr.score(x, y)


def optimize(selected, rest, k, data):

    if len(selected) == k:
        return selected

    # Create different options
    options = [selected + [rest[i]] for i in range(0, len(rest))]

    # Compute best combination
    best = []
    best_r = 0
    for option in options:
        r = regresion(data[option], data.iloc[:, 1].to_frame())
        if r > best_r:
            best = option
            best_r = r

    # Log chosen in this step
    print(best)
    print(best_r)

    # Compute rest
    all = selected + rest
    new_rest = [item for item in all if item not in best]

    # Store result in file
    f = open('voraz.csv', 'a')
    f.write(str(best_r) + "\r\n")
    f.close()

    # Iterate
    return optimize(best, new_rest, k, data)


def main():
    all = ["Density", "Age", "Weight", "Height", "Adiposity", "FatFreeWt", "Neck", "Chest",
           "Abdomen", "Hip", "Thigh", "Knee", "Ankle", "Biceps", "ForeArm", "Wrist"]
    start = []
    rest = [item for item in all if item not in start]
    data = pd.read_csv("datos_obesidad.csv", sep=',')

    # Greedy algorithm to find best k regressors
    k = 8
    best = optimize(start, rest, k, data)
    print best


if __name__ == "__main__":
    main()
