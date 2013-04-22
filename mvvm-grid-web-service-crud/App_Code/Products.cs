﻿using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web.Script.Services;
using System.Web.Services;
using NorthwindModel;

/// <summary>
/// Sample ASP.NET service which performs CRUD (Create Read Update Destroy) operations over the Products table from the Northwind database. 
/// Entity Framework is used to perform the database access.
/// </summary>
[ScriptService] // allow the web service to be called from JavaScript
public class Products : System.Web.Services.WebService 
{
    /// <summary>
    /// Creates new products by inserting the data posted by the Kendo Grid in the database.
    /// </summary>
    /// <param name="products">The products created by the user.</param>
    /// <returns>The inserted products so the Kendo Grid is aware of the database generated ProductID</returns>
    [WebMethod]
    public GridModel Create(IEnumerable<ProductViewModel> products)
    {
        var result = new List<Product>();

        using (var northwind = new Northwind())
        {
            //Iterate all created products which are posted by the Kendo Grid
            foreach (var productViewModel in products)
            {
                // Create a new Product entity and set its properties from productViewModel
                var product = new Product
                {
                    ProductName = productViewModel.ProductName,
                    UnitPrice = productViewModel.UnitPrice,
                    UnitsInStock = productViewModel.UnitsInStock,
                    Discontinued = productViewModel.Discontinued
                };

                // store the product in the result
                result.Add(product);

                // Add the entity
                northwind.Products.AddObject(product);
            }

            // Insert all created products to the database
            northwind.SaveChanges();

            // Return the inserted products - the Kendo Grid needs their ProductID which is generated by SQL server during insertion

            return new GridModel()
            {
                Data = result.Select(p => new ProductViewModel
                {
                    ProductID = p.ProductID,
                    ProductName = p.ProductName,
                    UnitPrice = p.UnitPrice,
                    UnitsInStock = p.UnitsInStock,
                    Discontinued = p.Discontinued
                })
                .ToList()
            };
        }
    }

    /// <summary>
    /// Reads the available products to provide data for the Kendo Grid
    /// </summary>
    /// <returns>All available products</returns>
    [WebMethod]
    public GridModel Read(int take, int skip) 
    {
        using (var northwind = new Northwind())
        {
            IQueryable<ProductViewModel> data = northwind.Products
                // Use a view model to avoid serializing internal Entity Framework properties as JSON
                .Select(p => new ProductViewModel
                {
                    ProductID = p.ProductID,
                    ProductName = p.ProductName,
                    UnitPrice = p.UnitPrice,
                    UnitsInStock = p.UnitsInStock,
                    Discontinued = p.Discontinued
                });
            var total = data.Count();

            var gridModel = new GridModel()
            {
                 Data = data.OrderBy(p=>p.ProductID).Skip(skip)
                            .Take(take)
                            .ToList(),
                 Total = total
            };

            return gridModel;
        }
    }

    /// <summary>
    /// Updates existing products by updating the database with the data posted by the Kendo Grid.
    /// </summary>
    /// <param name="products">The products updated by the user</param>
    [WebMethod]
    public void Update(IEnumerable<ProductViewModel> products)
    {
        using (var northwind = new Northwind())
        {
            //Iterate all updated products which are posted by the Kendo Grid
            foreach (var productViewModel in products)
            {
                // Create a new Product entity and set its properties from productViewModel
                var product = new Product
                {
                    ProductID = (int)productViewModel.ProductID,
                    ProductName = productViewModel.ProductName,
                    UnitPrice = productViewModel.UnitPrice,
                    UnitsInStock = productViewModel.UnitsInStock,
                    Discontinued = productViewModel.Discontinued
                };

                // Attach the entity
                northwind.Products.Attach(product);
                // Change its state to Modified so Entity Framework can update the existing product instead of creating a new one
                northwind.ObjectStateManager.ChangeObjectState(product, EntityState.Modified);
            }

            // Save all updated products to the database
            northwind.SaveChanges();
        }
    }

    /// <summary>
    /// Destroys existing products by deleting them from the database.
    /// </summary>
    /// <param name="products">The products deleted by the user</param>
    [WebMethod]
    public void Destroy(IEnumerable<ProductViewModel> products)
    {
        using (var northwind = new Northwind())
        {
            //Iterate all destroyed products which are posted by the Kendo Grid
            foreach (var productViewModel in products)
            {
                var product = northwind.Products.FirstOrDefault(p => p.ProductID == productViewModel.ProductID);
                if (product != null)
                {
                    northwind.Products.DeleteObject(product);
                }

            }

            // Delete the products from the database
            northwind.SaveChanges();
        }
    }
}