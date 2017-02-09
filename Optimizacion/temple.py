import pandas as pd
from sklearn import linear_model


def regresion(x, y):
    # Create linear regression object
    regr = linear_model.LinearRegression()
    regr.fit(x, y)
    return regr.score(x, y)


def optimize(selected, all, data, best_worst_r=0.0, ck=20):

    # Compute best combination
    best = selected
    r = regresion(data[best], data.iloc[:, 1].to_frame())
    best_r = r
    original_best_r = best_r
    print("Current combination: " + str(best))
    print("Current R^2: " + str(best_r))

    # Get all neighbors
    options = neighbors(selected, all, [], len(selected) - 1)
    print(len(options))

    # Get best neighbor
    for option in options:
        r = regresion(data[option], data.iloc[:, 1].to_frame())
        if r > best_r:
            best = option
            best_r = r
        else:
            if r > best_worst_r and best_r - r < 0.05:
                best = option
                best_r = r
                best_worst_r = r
                #print("Pichor mejor: " + str(best_worst_r))

    # Log chosen in this step
    print(best) if best != selected else "No better neighbor found"
    print(best_r) if best != selected else "No better neighbor found"

    # Stop if not improving
    if ck == 0:
        return best

    # Store result in file
    f = open('temple.csv', 'a')
    f.write(str(best_r) + "\r\n")
    f.close()

    # Iterate
    return optimize(best, all, data, best_worst_r, ck - 1)


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
    start = ["Abdomen", "Age", "Thigh", "Neck", "Ankle", "Biceps", "Chest"]
    start = ["Age", "Hip", "Thigh", "Neck", "Ankle", "Wrist", "Height"]
    start = ['Density', 'FatFreeWt', 'Weight', 'Adiposity', 'Chest', 'Thigh', 'Wrist']
    start = ["Density", "Hip", "Thigh", "Knee", "Ankle", "Biceps", "ForeArm"]
    data = pd.read_csv("datos_obesidad.csv", sep=',')

    # Greedy algorithm to find best k regressors
    print("Starting point: " + str(start))
    best = optimize(start, all, data)
    print best


if __name__ == "__main__":
    main()
