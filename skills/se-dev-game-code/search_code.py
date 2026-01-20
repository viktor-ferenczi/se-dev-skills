#!/usr/bin/env python3
"""
C# Code Index Search Tool

This script searches through CSV index files created by index_csharp_codebase.py
and displays matching results with pagination support.

Usage:
    python search_code.py <index_file> <max_results> <offset> <search_pattern>

Arguments:
    index_file      Path to the CSV index file to search
    max_results     Maximum number of results to display per page
    offset          Number of results to skip (for pagination, use 0 for first page)
    search_pattern  Search pattern to match. Supports:
                    - Simple text: matches any column containing the text (case-insensitive)
                    - Regex: prefix with 're:' for regex pattern (e.g., 're:^MyClass$')
                    - Exact: prefix with 'exact:' for case-sensitive exact match

Examples:
    # Search for all occurrences of "MyClass", show first 20 results
    python search_code.py CodeIndex/classes.csv 20 0 MyClass

    # Get the next page (results 21-40)
    python search_code.py CodeIndex/classes.csv 20 20 MyClass

    # Regex search for classes starting with "Test"
    python search_code.py CodeIndex/classes.csv 50 0 "re:^Test"

    # Exact case-sensitive match
    python search_code.py CodeIndex/variables.csv 100 0 "exact:userId"

    # Search in specific namespace (searches all columns)
    python search_code.py CodeIndex/methods.csv 30 0 "MyNamespace.MyClass"
"""

import csv
import re
import sys
from pathlib import Path
from typing import List, Tuple, Optional


class SearchPattern:
    """Handles different types of search patterns"""

    def __init__(self, pattern_str: str):
        self.original = pattern_str

        # Determine pattern type
        if pattern_str.startswith('re:'):
            # Regex pattern
            self.mode = 'regex'
            pattern = pattern_str[3:]
            try:
                self.regex = re.compile(pattern, re.IGNORECASE)
            except re.error as e:
                print(f"Error: Invalid regex pattern '{pattern}': {e}", file=sys.stderr)
                sys.exit(1)
        elif pattern_str.startswith('exact:'):
            # Exact case-sensitive match
            self.mode = 'exact'
            self.text = pattern_str[6:]
        else:
            # Simple case-insensitive text search
            self.mode = 'simple'
            self.text = pattern_str.lower()

    def matches(self, row: List[str]) -> bool:
        """Check if any column in the row matches the pattern"""
        if self.mode == 'regex':
            return any(self.regex.search(cell) for cell in row)
        elif self.mode == 'exact':
            return any(self.text in cell for cell in row)
        else:  # simple
            return any(self.text in cell.lower() for cell in row)


class CodeIndexSearcher:
    """Searches through code index CSV files"""

    def __init__(self, index_file: str):
        self.index_file = Path(index_file)

        if not self.index_file.exists():
            print(f"Error: Index file '{index_file}' not found", file=sys.stderr)
            sys.exit(1)

        if not self.index_file.suffix == '.csv':
            print(f"Warning: File '{index_file}' does not have .csv extension", file=sys.stderr)

    def search(
        self,
        pattern: SearchPattern,
        max_results: int,
        offset: int
    ) -> Tuple[List[str], List[List[str]], int, bool]:
        """
        Search the index file for matching entries

        Returns:
            header: CSV header row
            results: List of matching rows (up to max_results)
            total_matches: Total number of matches found
            has_more: True if there are more results beyond max_results
        """
        header = None
        all_matches = []

        try:
            with open(self.index_file, 'r', encoding='utf-8', newline='') as f:
                reader = csv.reader(f)

                # Read header
                header = next(reader, None)
                if not header:
                    print(f"Error: Index file '{self.index_file}' is empty", file=sys.stderr)
                    sys.exit(1)

                # Search through rows
                for row in reader:
                    if pattern.matches(row):
                        all_matches.append(row)

        except Exception as e:
            print(f"Error reading index file: {e}", file=sys.stderr)
            sys.exit(1)

        # Apply pagination
        total_matches = len(all_matches)
        start_idx = offset
        end_idx = offset + max_results
        page_results = all_matches[start_idx:end_idx]
        has_more = end_idx < total_matches

        return header, page_results, total_matches, has_more


def print_help():
    """Print help message"""
    print(__doc__)


def format_csv_row(row: List[str]) -> str:
    """Format a CSV row for display, handling commas and quotes properly"""
    formatted_cells = []
    for cell in row:
        # Quote cells that contain commas, quotes, or newlines
        if ',' in cell or '"' in cell or '\n' in cell:
            # Escape quotes by doubling them
            cell = cell.replace('"', '""')
            formatted_cells.append(f'"{cell}"')
        else:
            formatted_cells.append(cell)
    return ','.join(formatted_cells)


def main():
    # Check for help request or wrong number of arguments
    if len(sys.argv) == 1 or (len(sys.argv) == 2 and sys.argv[1] in ['-h', '--help', '/help', '/?']):
        print_help()
        sys.exit(0)

    if len(sys.argv) != 5:
        print("Error: Invalid number of arguments\n", file=sys.stderr)
        print_help()
        sys.exit(1)

    # Parse arguments
    index_file = sys.argv[1]

    try:
        max_results = int(sys.argv[2])
        if max_results <= 0:
            raise ValueError("max_results must be positive")
    except ValueError as e:
        print(f"Error: Invalid max_results '{sys.argv[2]}': must be a positive integer", file=sys.stderr)
        sys.exit(1)

    try:
        offset = int(sys.argv[3])
        if offset < 0:
            raise ValueError("offset must be non-negative")
    except ValueError as e:
        print(f"Error: Invalid offset '{sys.argv[3]}': must be a non-negative integer", file=sys.stderr)
        sys.exit(1)

    search_pattern_str = sys.argv[4]

    # Create searcher and pattern
    searcher = CodeIndexSearcher(index_file)
    pattern = SearchPattern(search_pattern_str)

    # Perform search
    print(f"Searching '{index_file}' for pattern: {pattern.original}", file=sys.stderr)
    print(f"Mode: {pattern.mode}, Offset: {offset}, Max results: {max_results}", file=sys.stderr)
    print("", file=sys.stderr)

    header, results, total_matches, has_more = searcher.search(pattern, max_results, offset)

    # Print summary
    showing_start = offset + 1
    showing_end = offset + len(results)
    print(f"Found {total_matches} total matches. Showing {showing_start}-{showing_end}:", file=sys.stderr)
    print("", file=sys.stderr)

    # Print header
    print(format_csv_row(header))

    # Print results
    for row in results:
        print(format_csv_row(row))

    # Print continuation indicator if there are more results
    if has_more:
        print("...")
        remaining = total_matches - showing_end
        next_offset = offset + max_results
        print(f"\n{remaining} more results available. Use offset {next_offset} for next page.", file=sys.stderr)


if __name__ == '__main__':
    main()
