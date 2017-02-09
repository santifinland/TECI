import pandas as pd
from sklearn import linear_model


def regresion(x, y):
    # Create linear regression object
    regr = linear_model.LinearRegression()
    regr.fit(x, y)
    return regr.score(x, y)


def optimize(selected, all, data, version, x):

    # Compute best combination
    best = selected
    r = regresion(data[best], data.iloc[:, 1].to_frame())
    best_r = r
    original_best_r = best_r
    print("Current combination: " + str(best))
    print("Current R^2: " + str(best_r))

    # Get all neighbors
    options = neighbors(selected, all, [], len(selected) - 1)

    # Get best neighbor
    for option in options:
        r = regresion(data[option], data.iloc[:, 1].to_frame())
        if r > best_r:
            best = option
            best_r = r

    # Log chosen in this step
    print(best) if best != selected else "No better neighbor found"
    print(best_r) if best != selected else "No better neighbor found"

    # Store result in file
    x += 1
    f = open('vecinal.csv', 'a')
    f.write(str(x) + "," + str(best_r) + "," + str(version) + "\r\n")
    f.close()

    # Stop if not improving
    if best_r - original_best_r < 0.00000000000001:
        return best

    # Iterate
    return optimize(best, all, data, version, x)


def neighbors(original, all, acc, index):
    # If got all neighbors, return neighbors list
    if index == -1:
        return acc
    # Get all neighbors for current index
    combination = list(original)
    rest = [item for item in all if item not in original]
    combination.pop(index)
    acc += [combination + [rest[i]] for i in range(0, len(rest))]
    return neighbors(original, all, acc, index - 1)


def main():
    all = ["Density", "Age", "Weight", "Height", "Adiposity", "FatFreeWt", "Neck", "Chest",
           "Abdomen", "Hip", "Thigh", "Knee", "Ankle", "Biceps", "ForeArm", "Wrist"]
    start_1 = ["Abdomen", "Age", "Thigh", "Neck", "Ankle", "Biceps", "Chest"]
    start_2 = ["Age", "Hip", "Thigh", "Neck", "Ankle", "Wrist", "Height"]
    start_3 = ["Density", "Hip", "Thigh", "Knee", "Ankle", "Biceps", "ForeArm"]
    start_4 = ['Density', 'Abdomen', 'FatFreeWt', 'Weight', 'Adiposity', 'ForeArm', 'Chest', 'Thigh']
    data = pd.read_csv("datos_obesidad.csv", sep=',')

    # Greedy algorithm to find best k regressors
    version = ["red", "blue", "green", "yellow"]
    t = 0
    for i in [start_1, start_2, start_3, start_4]:
        print("Starting point: " + str(i))
        best = optimize(i, all, data, version[t], 0)
        t += 1
        print best


if __name__ == "__main__":
    main()
