import sys
import os
import csv
import math

# ------------------------------------------------------
# Main evaluation functions
# ------------------------------------------------------

def load_labels(fpath):
    try:
        labels = {}
        with open(fpath, 'rb') as fp:
            rd = csv.reader(fp)
            next(rd, None)
            for row in rd:
                labels[row[0]] = {
                    'mean': float(row[1]),
                    'stdv': float(row[2])
                }
        return labels
    except:
        print "Error (from codalab): Failed to read ground truth file!"
        exit(1)


def load_predictions(fpath):
    try:
        with open(fpath, 'rb') as fp:
            rd = csv.reader(fp)
            return {row[0]: float(row[1]) for row in rd}
    except:
        print "Error (from user): Failed to read predictions file! Please, make sure the format is correct:\n" + \
              "  - It SHOULD NOT contain a labels line at the beginning.\n" + \
              "  - Each line should consist of a file name and its predicted value, separated by a comma.\n" + \
              "  - Predicted values must be numeric, using a dot (.) to separate the decimal part, if present."
        exit(1)


def evaluate_predictions(gt, preds):
    # Calculate non-normalized score
    score, n_scored = (0, 0)
    for k, v in preds.iteritems():
        if k in gt:
            gt[k]['stdv'] = 0.162 if gt[k]['stdv'] < 0.162 else gt[k]['stdv']
            score = score + (1 - math.exp(-(v - gt[k]['mean'])**2 / (2*gt[k]['stdv']**2)))
            n_scored = n_scored + 1
        else:
            print "Warning (from user): Labeled instance '" + k + "' not present in the ground truth!"

    # If num. scored instances != number of ground truth instances, warn user
    if n_scored < len(gt):
        print "Warning (from user): Only " + str(n_scored) + "/" + str(len(gt)) + " instances were evaluated. " + \
              "Your maximum possible score is " + str(100*(n_scored / len(gt))) + "% of total."

    # Return score
    return score / len(gt)

def save_predictions(fpath, preds):
    with open(fpath, 'w') as fp:
        fp.write('Error: ' + str(preds))

# ------------------------------------------------------
# Initial checks and scripts params loading
# ------------------------------------------------------

# Check enough arguments are provided
if len(sys.argv) < 3:
    print "Error (from codalab): Not enough input arguments!"
    exit(1)

# Capture labels and predictions path
path_labels, path_preds, path_output = (
    sys.argv[1] + ('ref/' if sys.argv[1][-1] == '/' else '/ref/'),
    sys.argv[1] + ('res/' if sys.argv[1][-1] == '/' else '/res/'),
    sys.argv[2] + ('' if sys.argv[2][-1] == '/' else '/')
)

# Check labels path exists
if not os.path.exists(path_labels):
    print "Error (from codalab): Ground truth path doesn't exist!"

# Check predictions path exists
if not os.path.exists(path_preds):
    print "Error (from codalab): Predictions path doesn't exist!"


# ------------------------------------------------------
# Preparation of files
# ------------------------------------------------------

# Function to locate files of a given type
def find_nested_file(path, type):
    files = [
        root+('' if root.endswith('/') else '/')+f
        for root, _, files in os.walk(path) for f in files if f.endswith('.csv')
    ]
    return files if len(files) > 1 else (files[0] if len(files) == 1 else None)

# Locate ground truth file
fpath_labels = find_nested_file(path_labels, 'csv')
if fpath_labels is None:
    print "Error (from codalab): Ground truth CSV file not found!"
    exit(1)
elif isinstance(fpath_labels, list):
    print "Error (from codalab): Multiple CSV files found for the ground truth!"
    exit(1)

# Locate predictions file
fpath_preds = find_nested_file(path_preds, 'csv')
if fpath_preds is None:
    print "Error (from user): Predictions CSV file not found!"
    exit(1)
elif isinstance(fpath_preds, list):
    print "Error (from user): Multiple CSV files found for the predictions!"
    exit(1)

# Load ground truth & predictions
labels = load_labels(fpath_labels)
preds = load_predictions(fpath_preds)

# Evaluate predictions
score = evaluate_predictions(labels, preds)
save_predictions(path_output+'scores.txt', score)

pass