def mergeSort(lst):
    if len(lst)>1:
        mid = len(lst)//2
        lefthalf = lst[:mid]
        righthalf = lst[mid:]

        mergeSort(lefthalf)
        mergeSort(righthalf)

        i = 0, j = 0, k = 0

        while i < len(lefthalf) and j < len(righthalf):
            if lefthalf[i] < righthalf[j]:
                lst[k] = lefthalf[i]
                i = i + 1
            else:
                lst[k] = righthalf[j]
                j = j + 1
            k = k + 1

        while i < len(lefthalf):
            lst[k] = lefthalf[i]
            i = i + 1
            k = k + 1

        while j < len(righthalf):
            lst[k] = righthalf[j]
            j = j + 1
            k = k + 1

lst = [54,26,93,17,77,31,44,55,20]
print(mergeSort(lst))