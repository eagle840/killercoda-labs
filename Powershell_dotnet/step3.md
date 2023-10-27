# Step 3

# Step 3: Learn PowerShell and .NET Integration

## Scenario

In this lab, you will learn how to integrate PowerShell with .NET. You will create and manipulate .NET objects using PowerShell, call .NET methods, and access .NET properties.

## Step 1: Create a .NET Object

First, let's create a .NET object. We'll use the `System.DateTime` class as an example.

```powershell
$date = New-Object System.DateTime
```
`$date`{{exec}}

## Step 2: Access .NET Properties

Now, let's access some properties of the `System.DateTime` object.

```powershell
$date.Now
```
`$date.Now`{{exec}}

## Step 3: Call .NET Methods

Next, let's call a method on the `System.DateTime` object.

```powershell
$date.AddDays(7)
```
`$date.AddDays(7)`{{exec}}

## Step 4: Manipulate .NET Objects

Finally, let's manipulate a .NET object. We'll create a `System.Collections.ArrayList` object and add some items to it.

```powershell
$arrayList = New-Object System.Collections.ArrayList
$arrayList.Add("Item 1")
$arrayList.Add("Item 2")
$arrayList
```
`$arrayList`{{exec}}
