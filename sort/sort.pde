import java.util.*;

int[] arr;
HashSet<Integer> pivots;
HashSet<Integer> compares;
Stack<Integer> stack;
int unit = 12;
void setup()
{
  frameRate(30);
  size(600, 400);
  arr = new int[width/unit];
  background(#000000);
  setArray();
  pivots = new HashSet<Integer>();
  compares = new HashSet<Integer>();
  stack = new Stack<Integer>();
  stack.add(0); stack.add(arr.length-1);
  setMaxLast();
}
int bi=0;  int bj=0;
int si = 0;  int sj = 1;
int ii = 0;  int ij = -1;
int mi = 1;  int mj = 0;
int paintwhite = 0;
int paintyellow = 0;
int paintpink = 0;
int count = 0;
int minidx = 0;
int ikey = -1;
void draw()
{
  stroke(#F55B9B);
  background(#000000);
  for(int a=0; a<arr.length; a++)
  {
    if(a==paintwhite)
      fill(#FFFFFF);
    else if(a==paintyellow)
      fill(#F4F585);
    else if(a==paintpink)
      fill(#F585F3);
    else
     fill(#6B88F7);
    rect(unit*a, height-arr[a], unit, arr[a]);
  }
  textSize(50);
  fill(#FFFFFF);
  text(count, 50, 100, 10); 
    
  // Use mergesort with framerate - 5
    // mergesort();
  // Use quicksort with framerate - 15
    // quick();
  // For insertion, selection, and bubble, use framerate - 30
    // insertion();
    // selection();
    // bubble();
}

void mergesort()
{
  if(mi < arr.length)
  {
    if(mj < arr.length-1)
    {
      int mid = Math.min(mj + mi - 1, arr.length-1);
      int right = Math.min(mj+ 2*mi - 1, arr.length-1);
      paintpink = mj;
      paintwhite = mid;
      paintyellow = right;
      merge(arr, mj, mid, right);
      count += 2*(right - mj);
      mj += 2*mi;
    } 
    else 
    {
      mi = mi*2;
      mj = 0;
    }
  }
  else 
  {
    for(int a=0; a<arr.length; a++)
    {
      fill(#97F585);
      rect(unit*a, height-arr[a], unit, arr[a]);
    }
    noLoop();
  }
}

void merge(int[] a, int l, int m, int r)
{
  int n1 = m-l+1;
  int n2 = r-m;
  
  int[] temp1 = new int[n1];
  int[] temp2 = new int[n2];
  
  for(int i=0; i<n1; ++i)
    temp1[i] = a[l+i];
  
  for(int i=0; i<n2; ++i)
    temp2[i] = a[m+1+i];
  
  int x = 0;
  int y = 0;
  int k = l;
  
  while(x < n1 && y < n2)
  {
    if(temp1[x] <= temp2[y])
    {
      arr[k] = temp1[x];
      x++;
    }
    else
    {
      arr[k] = temp2[y];
      y++;
    }
    k++;
  }
  
  while(x < n1)
  {
    arr[k] = temp1[x];
    k++; x++;
  }
  while(y < n2)
  {
    arr[k] = temp2[y];
    k++; y++;
  }
}

void quick()
{
  if(!stack.isEmpty())
  {
    int h = stack.pop();
    int l = stack.pop();
    paintyellow = l;
    paintpink = h;
    int p = partition(l, h);
    paintwhite = p;
    
    if(p-1>l)
    {
      stack.push(l);
      stack.push(p);
    }
    if(p+1<h)
    {
      stack.push(p+1);
      stack.push(h);
    }
  }
  else 
  {
   for(int a=0; a<arr.length; a++)
    {
      fill(#97F585);
      rect(unit*a, height-arr[a], unit, arr[a]);
    }
    noLoop();
  }
}

int partition(int start, int end)
{
  int pivot = arr[start];
  int pivotidx = start;
  int i = start; int j = end;
  while(i<j)
  {
    do {
      i++;
      count++;
    } while(i< arr.length && arr[i] < pivot);
    do {
      j--;
      count++;
    } while(j> 0 && arr[j] > pivot);
    if(i<j)
      swap(arr, i, j);
  }
  swap(arr, j, pivotidx);
  count++;
  return j;
}
void insertion()
{
  if(ii<arr.length)
  {
    paintwhite = ii;
    if(ij >= 0 && arr[ij] > ikey)
    {
      paintyellow = ij;
      paintpink = ij+1;
      // System.out.println("j: "+ij+" i: "+ii);
      arr[ij+1] = arr[ij];
      ij = ij - 1;
      count++;
    }
    else 
    {
      arr[ij+1] = ikey>0 ? ikey : arr[0];
      count++;
      ii++;
      ij = ii - 1;
      ikey = ii<50 ? arr[ii] : -1;
    }
  }
  else
  {
    for(int a=0; a<arr.length; a++)
    {
      fill(#97F585);
      rect(unit*a, height-arr[a], unit, arr[a]);
    }
    noLoop(); 
  }
}

void selection()
{
  if(si<arr.length)
  {
    if(sj<arr.length)
    {
      paintyellow = sj;
      if(arr[sj]<arr[minidx])
      {
        minidx = sj;
        paintpink = sj;
      }
      sj++;
      count++;
    }
    else 
    {
      swap(arr, si, minidx);
      si++;
      sj = si+1;  
      paintwhite = si;
      minidx = si;
    }
  }
  else 
  {
    for(int a=0; a<arr.length; a++)
    {
      fill(#97F585);
      rect(unit*a, height-arr[a], unit, arr[a]);
    }
    noLoop();
  }
}

void bubble()
{
  if(bi<arr.length-1)
  {
    if(bj<arr.length-bi-1)
    {
      paintpink = bj;
      if(arr[bj]>arr[bj+1])
      {
        swap(arr, bj, bj+1);
        paintwhite = bj+1;
      }
      bj++;
      count++;
    }
    else 
    {
      bi++;
      bj=0;
    }
  }
  else
  {
    for(int a=0; a<arr.length; a++)
    {
      fill(#97F585);
      rect(unit*a, height-arr[a], unit, arr[a]);
    }
    noLoop(); 
  }
}

void swap(int[] a, int x, int y)
{
  int temp = a[x];
  a[x] = a[y];
  a[y] = temp;
}

void setMaxLast()
{
  int maxidx = 0;
  for(int i=1; i<arr.length; i++)
  {
    if(arr[i] > arr[maxidx])
      maxidx = i;
  }
  swap(arr, maxidx, arr.length-1);
}

void setArray()
{
  for(int i=0; i<arr.length; i++) 
    arr[i] = (int) ((Math.random())*(height-50));
}
