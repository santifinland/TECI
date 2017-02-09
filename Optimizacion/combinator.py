import pandas as pd
from sklearn import linear_model


def choose_iter(elements, length):
    for i in xrange(len(elements)):
        if length == 1:
            yield (elements[i],)
        else:
            for next in choose_iter(elements[i+1:len(elements)], length-1):
                yield (elements[i],) + next


def choose(l, k):
    return list(choose_iter(l, k))


def regresion(x, y):
    # Create linear regression object
    regr = linear_model.LinearRegression()
    regr.fit(x, y)
    return regr.score(x, y)


def neighbor(x, history, order=0, flag=True):
    all = ["Wrist", "Age", "Weight", "Adiposity", "Density", "FatFreeWt", "Neck", "Chest",
           "Abdomen", "Hip", "Thigh", "Knee", "Ankle", "Biceps", "ForeArm"]
    rest = [item for item in all if item not in x]
    #print("Rest")
    #print(rest)
    #first = x[0]
    #x = x[1:].append(first)
    #print("LLLLLLLLLLLLLLLLLLLLLLLLLL: " + str(len(x)))
    if len(x) < 7 and flag:
        substracted = x
    else:
        substracted = x[1:]
    #print("Substracted")
    #print(substracted)
    #print(order)
    #print(all[order])
    substracted.append(rest[order])
    #print("NNN")
    #print(substracted)
    if substracted not in history:
        history.append(substracted)
        return substracted, history
    else:
        if order > 4:
            return substracted, history
        return neighbor(x, history, order + 1, False)


def find_best_combination(k, better):
    combinations = list(choose_iter(["Density", "Age", "Weight", "Adiposity", "FatFreeWt", "Neck", "Chest",
                                     "Abdomen", "Hip", "Thigh", "Knee", "Ankle", "Biceps", "ForeArm", "Wrist"], k))
    data = pd.read_csv("datos_obesidad.csv", sep=',')
    for item in combinations:
        sol = regresion(data.iloc[:, 1].to_frame(), data[list(item)])
        if sol > better:
            print([item])
            better = sol
            print(better)
    return better


def optimize(items, better, history):
    data = pd.read_csv("datos_obesidad.csv", sep=',')
    best = items[0]
    #print(len(items))
    #print("Besti Op")
    #print(best)
    for x in items:
        #print("XXXXX")
        #print(x)
        sol = regresion(data[x], data.iloc[:, 1].to_frame())
        #print(sol)
        if sol - better > 0.001 or better - sol < 0.08:
            better = sol
            best = x
            #print("Better")
            print(better)
    if best != items[0] or len(history) == 0:
        news = []
        kk = len(items)
        flag = True
        for i in range(1, 8):
            (new, new_history) = neighbor(best, history, 0, flag)
            if i > 2:
                flag = False
            #print("New")
            #print(new)
            #print("History")
            #print(new_history)
            news.append(new)
        #print("NEW hist")
        #print(new_history)
        optimize(news, better, new_history)
    else:
        print("End")
        print(better)
        print(best)
        sol = regresion(data.iloc[:, 1].to_frame(), data[best])
        print(sol)


def main():
    better = 0
    #for k in range(7, 8):
        #better = find_best_combination(k, better)
    start = [['Abdomen', 'Weight', 'Adiposity', 'FatFreeWt', 'Neck', 'Chest', 'Age']]
    start = [['Abdomen']]
    #start = [['Adiposity', 'FatFreeWt', 'Age', 'Neck']]
    optimize(start, better, [])


if __name__ == "__main__":
    main()
